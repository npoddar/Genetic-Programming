function netExcess = powersched1(x)

%x(1-4) represent the schedule for unit 1
%x(5-8) represent the schedule for unit 2
%x(9-12) represent the schedule for unit 3
%x(13-16) represent the schedule for unit 4
%x(17-20) represent the schedule for unit 5
%x(21-24) represent the schedule for unit 6
%x(25-28) represent the schedule for unit 7
unit1 = [x(1) x(2) x(3) x(4)];
unit2 = [x(5) x(6) x(7) x(8)];
unit3 = [x(9) x(10) x(11) x(12)];
unit4 = [x(13) x(14) x(15) x(16)];
unit5 = [x(17) x(18) x(19) x(20)];
unit6 = [x(21) x(22) x(23) x(24)];
unit7 = [x(25) x(26) x(27) x(28)];

%Set a default value of netExcess to some high value to ensure that
%Matlab picks a valid power schedule
netExcess = 500;
%Set power requirements for the system
powerReq = [80 90 65 70];
%Zero initial sum
tempSum = 0;
%Set up vector to sum power schedule for validity
vectorSum = [1 1 1 1]';
%Set up loop to find the power capability for each interval
for k = 1:4,
    totalCap = unit1(k)*20 + unit2(k)*15 + unit3(k)*35 + unit4(k)*40 + unit5(k)*15 + unit6(k)*15 + unit7(k)*10;
    %Find net excess power for chosen power schedule
    %Sum over all intervals
    if((150-totalCap)>=powerReq(k))
    tempSum = tempSum + (150 - totalCap)- powerReq(k);
    end
end

%The code following determines whether the genetic algorithm has
%chosen a valid power schedule or not.
unit1Good = 0;
unit2Good = 0;

%This for loop checks that for the first two units, two consecutive
%intervals have been chosen to execute maintenance
for k = 1:3,
    if x(k) == 1
        if x(k+1) == 1
            unit1Good = 1;
        end
    end
    if x(k+4) == 1
        if x(k+5) == 1
            unit2Good = 1;
        end
    end
end

%The following if statements determine that a valid power schedule has been
%chosen by summing all the bits in the power schedule for a unit and
%testing with the valid number of bits
%For Example:
%Unit 3 may only be scheduled for maintenance for only 1 interval
%translating to a value of [1 0 0 0][0 1 0 0][0 0 1 0], or [0 0 0 1]
%Multiplying this bit vector by the column vector [1;1;1;1] sums the
%number of bits. Those number of bits must then equal 1 for unit 3.
if unit1Good == 1
  if unit2Good == 1
    if (unit1*vectorSum) == 2
      if (unit2*vectorSum) == 2
        if (unit3*vectorSum) == 1
          if (unit4*vectorSum) == 1
            if (unit5*vectorSum) == 1
              if (unit6*vectorSum) == 1
                if (unit7*vectorSum) == 1
                  %If a valid powersched is not chosen,
                  %netExcess keeps its default high value
                  %and the genetic has to pick a new
                  %power schedule to achieve a minimum.
                  netExcess = tempSum;
                end
              end
            end
          end
        end
      end
    end
  end
end
