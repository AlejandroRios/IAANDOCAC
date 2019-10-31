function [coordinates,header]=get_airfoil_coord(fileToRead1)
%IMPORTFILE(airfoil_file)
%  Imports info from the specified file
%  airfoil_file:  file to read
%INPUT
%airfoil_file: name of the file containing the coordinates. The file's
%first line must be the header. Then, the
%coordinates must be placed in the lines below. Ex:
%AG 35
%   1.0 0.0
%   0.98 0.01
%   ... ...

%OUTPUT
%coordinates: a matrix with the airfoil coordinates
%header: string with the header of the file

DELIMITER = ' ';
HEADERLINES = 1;

% Import the file
newData1 = importdata(fileToRead1, DELIMITER, HEADERLINES);

% Create new variables in the base workspace from those fields.
vars = fieldnames(newData1);
for i = 1:length(vars)
    assignin('caller', vars{i}, newData1.(vars{i}));
end

coordinates=newData1.data;
header=newData1.textdata;

%%%%%%%%%%%%%%%%%%%%%%