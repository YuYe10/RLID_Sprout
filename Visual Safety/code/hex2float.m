%把十六进制转化为浮点数
function bits_float=hex2float(hex)

bits_32=hexToBinaryVector(hex,32);%把十六进制转化为2进制(共有32位数)

char_bits_32=char(bits_32+'0');%logical 转换为 char,再转化为字符型

bits_float=bin2float(char_bits_32);