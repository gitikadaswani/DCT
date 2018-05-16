clearvars
[x_input,Fs]=audioread('0082.wav');

    subplot(3,2,1)       
    plot(x_input)
    ylim([-1 1])
    title('input')

y_output=dct(x_input);

[sort_y,ind] = sort(abs(y_output),'descend'); %abs gives absolute value for real input and magnitude for complex input

    subplot(3,2,3)       
    plot(y_output)
    title('dct')

%     subplot(3,2,3)       
%     plot(sort_y)
%     title('sorted dct')

need = 1;
while norm(sort_y(1:need))/norm(y_output)<0.80
   need = need+1;
end
xpc = need/length(y_output)*100;
var=['% of co-efficients: ',num2str(xpc)];
disp(var);
y_output(ind(need+1:end)) = 0;


    subplot(3,2,4)       
    plot(y_output)
    title('elimination of coefficients')


x_output=idct(y_output);

    subplot(3,2,5)       
    plot(y_output)
    title('idct')


audiowrite('<local directory>',x_output,Fs);

x_output(x_output ~= 0);

    subplot(3,2,2)      
    plot(x_output)
    title('output')
compression_ratio=nnz(x_input)/nnz(y_output); 
var=['Compression Ratio: ', num2str(compression_ratio)];
disp(var);

redundancy=1-(1/compression_ratio);
var=['Redundancy: ', num2str(redundancy)];
disp(var);

