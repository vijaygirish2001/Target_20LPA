%Code to control the speed of the motor based on the ambient temperature of the room


clc;                %Clears the command window screen
clear all;          %Clears the workspace of all variables
close all;          %Closes all open figures
load var.mat;       % Loads previous saved workspace containing the password and  Temparature -RPM map from var.mat on disk
ambient=19;         % sets the default ambient temperature to 19C
    disp(['Temperature   Fan''s Rotation']);        % Displays ambient temperature and the corresponding fan's rotation
    disp([num2str(ambient) 'C            ' num2str(temp_rpm(ambient-14,2)) 'rpm']);
a=0;
p='    ';
while(a==0)
p=input('Enter PIN to change system paramaters: ','s');     %Taking input from User for PIN authentication 
    if length(p)==4
        if( p==pin)
            break;
        else
            tic;                                                % Starts timer for counting 3 seconds
            disp(['Wrong PIN, reenter PIN']);
            while(toc<3)
            end
        end
    else
        disp(['PIN should be of four characters']);
    end
end
clc
motor=[];                                                      % motor is the variable containing the speed of the motor in rpm from starting to ending point
while(a==0)
    disp(['Temperature   Fan''s Rotation']);
    disp([num2str(ambient) 'C           ' num2str(temp_rpm(ambient-14,2)) 'rpm']);
    disp(['  ']);
    disp([' Please select one of the following:']);                             % Options for Configuration Menu
    disp(['1. Change PIN number']);
    disp(['2. Stop Motor']);
    disp(['3. Start Motor']);
    disp(['4. Change Direction']);
    disp(['5. Configure Temperature vs RPM']);
    disp(['6. Change ambient Temperature']);                                    % To Change ambient temperature of the room                                 

    n=input('Enter option (Enter 0 to exit):');                                 
    strt=800;                                                                   % strt is the time taken to start and the motor, i.e. the time during which the motor is in ramp condition          
    if length(n)>0
    if n>=0 && n<=6
        switch n
        case 0
        return;      
        case 1
            p=input('Enter old PIN number:','s');
            if length(p)==4
                if( p==pin)                                                     % pin is the variable which contains the original stored PIN        
                    p=input('Enter new PIN number:','s');                       % p is the variable which accepts new PIN 
                    if length(p)==4
                        p1=input('Reenter new PIN number:','s');
                        if length(p)==length(p1)
                        elseif p==p1
                            pin=p;
                            save('var.mat','pin','temp_rpm');                   % saves the changed PIN to the file var.mat
                            disp(['New PIN saved']);
                        else
                            disp(['Not matching with previously entered new PIN, retry']);
                        end
                    else
                        disp(['New PIN should be four characters wide']);
                    end
                else
                    disp(['Wrong PIN, retry']);         
                end
            else
            disp(['PIN should be of four characters']);
            end
            
        case 2
            if(length(motor)>0)
            stime=toc                                                %stime is the time elapsed from when the motor is started to when it is stopped
                if motor(length(motor))>0                           %When motor is running in forward direction
                    if toc>1
                    motor=[ motor ones(1,(stime*1000-strt))*temp_rpm(ambient-14,2) linspace(temp_rpm(ambient-14,2),0,strt+1)];
                    t=[0:length(motor)-1];           % t is the time from starting to the the stopping of the motor in ms
                    
                    end
                else                                                  %When motor is running in reverse direction
                    motor=[ motor ones(1,(stime*1000-strt))*(-temp_rpm(ambient-14,2)) linspace(-temp_rpm(ambient-14,2),0,strt+1)];
                    t=[0:length(motor)-1]; 

                end  
                plot(t./1000,motor);
                title(' Plot of speed in rpm vs time in seconds');
                xlabel('Time in seconds');
                ylabel('Speed in rpm');
                grid on;
                hold;
            motorend=motor;
            timeend=t;
            motor=[];
            t=[];
            end
            clc;
        case 3
            close all;
            motor=linspace(0,temp_rpm(ambient-14,2),strt+1);
                      
            tic
            t=[0:strt];
            clc
            disp(['Motor has started!']);
        case 4   
            if(length(motor)>0)
            stime=toc;
                      %in ms
                if motor(length(motor))>0
                    if toc>1
                    motor=[ motor ones(1,(stime*1000-strt))*temp_rpm(ambient-14,2) linspace(temp_rpm(ambient-14,2),-temp_rpm(ambient-14,2),2*strt)];
                    t=[t t(length(t)):(stime)*1000+2*strt-1]; 
                    
                    end
                else
                    motor=[ motor ones(1,(stime*1000-strt))*(-temp_rpm(ambient-14,2)) linspace(-temp_rpm(ambient-14,2),temp_rpm(ambient-14,2),2*strt)];
                    t=[t t(length(t)):(stime)*1000+2*strt-1]; 

                end  
            clc
                if motor(length(motor))>0
                    disp(['Motor is running in reverse direction!']);   
                else
                    disp(['Motor is running in forward direction!']);  
                end
                    
                
            end
        case 5
            disp(['Temperature RPM (Configured values)']);
            temp_rpm                                                    % Displays the pre configured temperature vs speed in rpm values
            tp=input('Enter the temperature in celsius for which you wish to program the rpm(15 to 35):');      %tp is the temperature for which you wish to change the rpm
            if length(tp)>0
                if tp>=15 && tp<=35
                     rp=input('Enter the speed in rpm:');
                   while(length(rp)<1)
                       rp=input('Enter the speed in rpm:');
                   end
                       temp_rpm(tp-14,2)=rp;
                       save('var.mat','pin','temp_rpm');
                       disp(['RPM has been configured for ' num2str(tp) 'C']);
                else
                       disp(['Temperature entered is out of range']);
                    
                end
            end
            
        case 6
          
            am=input('Enter the ambient temperature in celsius: ');      
            if length(am)>0
                if am>=15 && am<=35
                     ambient=am;
                else
                     disp(['Temperature entered is out of range']);
                end
            end
          

        otherwise
        end  
    else
            
            disp(['Invalid option']);           %When option selected is out of range 
            
        
    end
    end
end
 

    motorend=motor;
    timeend=t;


