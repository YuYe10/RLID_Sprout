%数据损失攻击

function after_I=data_loss(R,pro,key)
rng(key);
loss=randsrc(512,512,[[0,1]; [pro,1-pro]]);

for i=1:1:512
   for j=1:1:512
       if loss(i,j)==0
          R(i,j)=0; 
       end
   end
end
after_I=R;