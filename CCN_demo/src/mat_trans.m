function trans = mat_trans(kenerl,frame_size)

[line,row] = size(kenerl);
A_1 = (frame_size-row)+1;%
A_2 = (frame_size-line)+1;
A_3 = A_1*A_2;

oral = frame_size^2;

  middle = zeros(1,oral); 

middle_1 = zeros(A_1,oral);

trans = zeros(A_3,oral);
%trans = zeros(A_3,1024);



for k=1:A_2
for j=1:A_1
  middle(:,:) = 0;
 for i=1:row
  middle(1,frame_size*(i+k-2)+j:row+frame_size*(i+k-2)+j-1) = kenerl(i,:);
 end
 middle_1(j,1:oral) = middle; 
end 
trans(A_1*(k-1)+1:A_1*k,1:oral) = middle_1;
end

