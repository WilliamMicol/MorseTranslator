
go = true;
file;

while go
x=serial('/dev/cu.usbmodem14101','BAUD', 9600);

fopen(x);
[morseArray,delay] = morseCode('bruh.txt');
stopper = 0;
for i = 1:length(morseArray)
      while stopper == 0
        pause(length(morseArray)/6.0);
%         stopper = input('fuck');
        stopper=1; 
      end
    fprintf(x, morseArray(i));
%     pause(.1);
    
end
if a == 2
    go=false;
end
pause(delay);
delete(x);
file1=dir('bruh.txt');
while(strcmp(file.date,file1.date) == 1)
   file1=dir('bruh.txt');
end
file = dir('bruh.txt');

end

% while go
%                  
% a= input('Press 1 to turn ON LED & 0 to turn OFF:');
% fprintf(x,a);  
% 
% if (a == 2)
%   go=false;
% end
% end


function [f, delay] = morseCode(file)
    charFile = char(fileread(file));
    stringFile = "";
    letters = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z',' '];
    lettersl = ['a','b','b','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',' '];
    code = ["*- ",'-*** ','-*-* ','-** ','* ','**-* ','--* ','**** ','** ','*--- ','-*- ','*-** ','-- ','-* ','--- ','*--* ','--*- ','*-* ','*** ','- ','**- ','***- ','*-- ','-**- ','-*-- ','--** ',' '];
    for i = 1:length(charFile)
        chara = charFile(i);
        for j = 1 : 27
           if chara == letters(j)
               stringFile = strcat(stringFile,code(j));
               break;
           elseif chara == lettersl(j)
               stringFile = strcat(stringFile,code(j));
               break;
           end
        end
    end
    morseString = char(stringFile)
    intFile = zeros(length(morseString) + 1, 1);
    numOfDot = 0.0;
    numOfDash = 0.0;
    numOfSpace = 0.0;
    for i = 1:length(morseString)
        if morseString(i) == '*'
            intFile(i) = 1;
            numOfDot = numOfDot + 1;
        elseif morseString(i) == '-'
            intFile(i) = 2;
            numOfDash = numOfDash + 1;
        elseif morseString(i) == ' '
            intFile(i) = 0;
            numOfSpace = numOfSpace + 1;
        end
    end
    intFile(length(morseString)+1) = 3;
    delayTime = numOfDot*.06+numOfDash*.31+numOfSpace*.31;
    delay = delayTime*3;
    f = intFile;
    
end