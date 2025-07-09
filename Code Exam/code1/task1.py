import gym  # 导入OpenAI Gym库，用于创建环境
import torch  # 导入PyTorch库，用于深度学习模型的构建和训练
import torch.nn as nn  # 导入PyTorch的神经网络模块
import torch.optim as optim  # 导入PyTorch优化器模块
import numpy as np  # 导入Numpy库，用于高效的数值计算
from collections import deque  # 导入deque数据结构，用于实现经验回放
import random  # 导入随机数生成库，用于epsilon-greedy策略中的随机选择
import matplotlib.pyplot as plt  # 导入Matplotlib库，用于绘制图形

# 超参定义
STATE_DIM = 2 # MountainCar-v0状态空间有2个维度（位置和速度） 
ACTION_DIM = 3 # MountainCar-v0动作空间有3个离散动作（0, 1, 2） 
GAMMA = 0.99 # 折扣因子，决定了未来奖励的重要性 
LEARNING_RATE = 1e-3 # 学习率，控制参数更新的步幅 
BATCH_SIZE = 64 # 每次训练时从经验回放中取出的批次大小 
REPLAY_BUFFER_SIZE = 100000 # 经验回放的缓冲区大小 
EPSILON_START = 1.0 # epsilon-greedy策略的起始epsilon值 
EPSILON_END = 0.01 # epsilon-greedy策略的结束epsilon值 
EPSILON_DECAY = 200 # epsilon衰减的速度（即在多少步内衰减到最小值） 
TARGET_UPDATE_FREQ = 10 # 每训练多少个episode后更新一次目标网络 
MAX_EPISODES = 1500 # 最大训练episode数量 
MAX_STEPS = 500 # 每个episode的最大步骤数	

#DQN网络模型构建
class DQN(nn.Module):
    def __init__(self):
        super(DQN, self).__init__()
        # 网络层：从状态维度到隐藏层（64个节点），再到输出层（与动作数量相同的维度）
        self.fc1 = nn.Linear(STATE_DIM, 64)  # 输入状态维度到隐藏层
        self.fc2 = nn.Linear(64, 64)         # 隐藏层到隐藏层
        self.fc3 = nn.Linear(64, ACTION_DIM) # 隐藏层到输出层

    def forward(self, state):
        # 前向传播：依次经过每一层并应用ReLU激活函数
        x = torch.relu(self.fc1(state))
        x = torch.relu(self.fc2(x))
        x = self.fc3(x)
        return x # 输出动作值（Q值）

#动作选择策略
def select_action(state, epsilon, policy_net):
    if random.random() < epsilon:  # 以epsilon的概率进行随机选择（探索）
        return random.randrange(ACTION_DIM)
    else:  # 否则选择Q值最大的动作（利用）
        with torch.no_grad():  # 不需要计算梯度
            state_tensor = torch.FloatTensor(state).unsqueeze(0).to(device)  # 转换为tensor并增加维度
            q_values = policy_net(state_tensor)  # 计算每个动作的Q值
            return torch.argmax(q_values).item()  # 返回Q值最大的动作

#ReplayBuffer类构建
class ReplayBuffer:
    def __init__(self, capacity):
        self.buffer = deque(maxlen=capacity)  # 使用deque来存储经验，最大长度为capacity

    def push(self, transition):
        self.buffer.append(transition)  # 添加新的经验到缓冲区

    def sample(self, batch_size):
        return random.sample(self.buffer, batch_size)  # 随机抽取一个batch的经验

    def __len__(self):
        return len(self.buffer)  # 返回缓冲区中经验的数量

# 自定义奖励函数，鼓励智能体更聪明的探索
def modified_reward(position, velocity, done):
    reward = -1  # 每一步默认奖励为-1，表示智能体未到达目标
    if position >= 0.5:
        reward = 0  # 到达目标时，奖励为0
    elif velocity > 0:
        reward += 0.1  # 如果速度为正，表示车子向右移动，给予额外奖励
    return reward

#模型训练
def train_dqn():
    # 创建环境
    env = gym.make('MountainCar-v0')
    # 初始化Q网络和目标网络
    policy_net = DQN().to(device)
    target_net = DQN().to(device)
    target_net.load_state_dict(policy_net.state_dict())  # 将目标网络的参数初始化为策略网络的参数
    target_net.eval()  # 设置目标网络为评估模式（不进行反向传播）

    # 优化器
    optimizer = optim.Adam(policy_net.parameters(), lr=LEARNING_RATE)

    # 经验回放缓冲区
    replay_buffer = ReplayBuffer(REPLAY_BUFFER_SIZE)

    # 训练过程
    episode_rewards = []  # 用于记录每个episode的总奖励
    epsilon = EPSILON_START  # 初始epsilon值
    for episode in range(MAX_EPISODES):
        state, _ = env.reset()  # 重置环境
        state = np.array(state, dtype=np.float32)  # 确保状态为float32类型
        episode_reward = 0  # 每个episode的奖励初始化为0

        for step in range(MAX_STEPS):
            action = select_action(state, epsilon, policy_net)  # 选择动作
            next_state, _, done, _, _ = env.step(action)  # 执行动作并得到下一个状态
            next_state = np.array(next_state, dtype=np.float32)  # 确保下一个状态为float32类型

            # 根据自定义奖励函数计算奖励
            reward = modified_reward(state[0], state[1], done)

            # 将经验存储到经验回放缓冲区
            replay_buffer.push((state, action, reward, next_state, done))
            state = next_state  # 更新状态
            episode_reward += reward  # 累加本轮的奖励

            # 如果经验回放缓冲区中有足够的经验，就开始训练
            if len(replay_buffer) > BATCH_SIZE:
                transitions = replay_buffer.sample(BATCH_SIZE)  # 从缓冲区中随机抽取一个batch
                batch = list(zip(*transitions))

                # 将数据转换为PyTorch张量
                states = torch.FloatTensor(batch[0]).to(device)
                actions = torch.LongTensor(batch[1]).unsqueeze(1).to(device)
                rewards = torch.FloatTensor(batch[2]).to(device)
                next_states = torch.FloatTensor(batch[3]).to(device)
                dones = torch.BoolTensor(batch[4]).to(device)

                # 计算Q值
                q_values = policy_net(states).gather(1, actions)  # 获取当前状态下选定动作的Q值
                next_q_values = target_net(next_states).max(1)[0]  # 获取下一个状态下最大的Q值
                target_q_values = rewards + (GAMMA * next_q_values * ~dones)  # 计算目标Q值

                # 计算损失
                loss = nn.MSELoss()(q_values.squeeze(), target_q_values)

                # 反向传播并更新策略网络
                optimizer.zero_grad()
                loss.backward()
                optimizer.step()

            if done:
                break

        episode_rewards.append(episode_reward)  # 记录每个episode的奖励

        # 更新epsilon，逐渐减少探索的比例
        epsilon = max(EPSILON_END, epsilon - (EPSILON_START - EPSILON_END) / EPSILON_DECAY)

        # 每隔一段时间更新目标网络
        if episode % TARGET_UPDATE_FREQ == 0:
            target_net.load_state_dict(policy_net.state_dict())

        print(f"Episode {episode}/{MAX_EPISODES}, Reward: {episode_reward}, Epsilon: {epsilon:.2f}")
    torch.save(policy_net.state_dict(), 'policy_net.pth')  # 保存训练好的策略网络

    # 绘制学习曲线
    plot_learning_curve(episode_rewards)

# 测试循环，评估模型的表现
def test_dqn():
    env = gym.make('MountainCar-v0', render_mode='human')
    total_rewards = []
    success_count = 0

    for episode in range(10):  # 进行10个测试episode
        state, _ = env.reset()  # 重置环境
        state = np.array(state)
        episode_reward = 0

        for step in range(MAX_STEPS):
            env.render()  # 渲染环境，显示模拟过程
            action = select_action(state, 0, policy_net)  # 测试时epsilon=0，完全利用策略网络
            next_state, reward, done, _, _ = env.step(action)  # 执行动作并得到结果
            state = np.array(next_state)
            episode_reward += reward  # 累加奖励
            if done:
                if state[0] >= 0.5:  # 如果车子到达目标位置，则视为成功
                    success_count += 1
                break

        total_rewards.append(episode_reward)

    # 计算平均奖励和成功率
    avg_reward = np.mean(total_rewards)
    success_rate = success_count / 10.0  # 成功率

    print(f"Test Results - Avg Reward: {avg_reward:.2f}, Success Rate: {success_rate * 100:.2f}%")
    env.close()

# 绘制学习曲线
def plot_learning_curve(episode_rewards):
    plt.plot(episode_rewards)
    plt.xlabel('Episodes')
    plt.ylabel('Reward')
    plt.title('Learning Curve (Reward per Episode)')
    plt.show()

# 主程序入口
if __name__ == "__main__":
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")  # 检查是否有GPU

    # 第一次代理环境运行（可以选择注释掉）
    #run_env()

    # 训练DQN
    train_dqn()

    # 加载训练好的策略网络并进行测试
    policy_net = DQN().to(device)
    policy_net.load_state_dict(torch.load('policy_net.pth', weights_only=True))  # 加载训练好的模型权重
    policy_net.eval()  # 设置为评估模式

    # 测试训练好的模型
    test_dqn()