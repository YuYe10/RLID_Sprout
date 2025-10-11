function decNum = bin2dec128(binStr)
% BIN2DEC128 converts a binary string to a decimal number, supporting up
% to 128 bits.
%
% Inputs:
%   - binStr: a binary string of up to 128 bits
%
% Output:
%   - decNum: a decimal number
%
% Example:
%   >> bin2dec128('1100100100010010111110010001010001001001000000001010001010100101101111101110010110100101100111')
%   ans =
%       9876543210123456789012345678901234567
%
% Reference: https://www.mathworks.com/matlabcentral/answers/301911-convert-binary-of-size-256-to-decimal

% Convert binary string to array of characters
binChars = num2cell(binStr);
binChars = [binChars{:}];

% Convert array of characters to numeric array
binNums = str2double(binChars);

% Reverse the array of numeric values
binNums = flip(binNums);

% Calculate the decimal number
decNum = sum(binNums .* (2 .^ (0:length(binNums)-1)));
end