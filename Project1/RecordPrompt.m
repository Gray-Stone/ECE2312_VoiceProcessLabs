function [] = RecordPrompt(text)
%RECORDPROMP �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
fprintf("---> read the following phrase after countdown <---\n\n");
fprintf("---> %s <---\n\n" ,text);
lineLength = fprintf("|||> Press ENTER to start countdown ");

input("")

fprintf(repmat('\b',1,lineLength+1))

end

