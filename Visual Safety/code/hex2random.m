function r=hex2random(hex_r)

bits_128=hexToBinaryVector(hex_r,128);%把十六进制转化为2进制(共有32位数)
char_bits_128=char(bits_128+'0');%logical 转换为 char,再转化为字符型
dec_r=bin2dec128(char_bits_128);

key=mod(dec_r,2^32);
rng(key)
r=randperm(1000,1)+500; 

