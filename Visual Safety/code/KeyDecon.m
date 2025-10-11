function [x1,y1,a,b,r]=KeyDecon(key)
%key是256bit的密钥，十六进制（64位）

hex_x1=key(1,1:8);
hex_y1=key(1,9:16);
hex_a=key(1,17:24);
hex_b=key(1,25:32);
hex_r=key(1,33:64);%128bit

x1=hex2float(hex_x1);
y1=hex2float(hex_y1);
a=mod(hex2dec(hex_a),100)+1;
b=mod(hex2dec(hex_b),100)+1;
r=hex2random(hex_r);%随机数生成了

