import gym

# Create the CartPole environment
env = gym.make('CartPole-v1', render_mode='human')

# Reset the environment to get the initial state
state = env.reset()

# Run a simple loop to interact with the environment
for _ in range(1000):
    # Render the environment
    env.render()

    # Take a random action
    action = env.action_space.sample()

    # Excute the action and get the next state, reward, done flag, etc.
    next_state, reward, terminated, truncated, info = env.step(action)
    done = terminated or truncated

    # If the episode is done, reset the environment
    if done:
        state, _ = env.reset()
    else:
        state = next_state

# Close the environment
env.close()
