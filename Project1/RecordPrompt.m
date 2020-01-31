function [] = RecordPrompt(text)
%RECORDPROMP 此处显示有关此函数的摘要
%   此处显示详细说明
fprintf("---> read the following phrase after countdown <---\n\n");
fprintf("---> %s <---\n\n" ,text);
lineLength = fprintf("|||> Press ENTER to start countdown ");

input("")

fprintf(repmat('\b',1,lineLength+1))

end

