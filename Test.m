

while 1
    pressed = brick.TouchPressed(4);
    %disp(GetColor(brick, 3));
    disp(brick.GyroAngle(2));
    
    if isnan(pressed)
        disp("nan");
    elseif pressed
        brick.beep();
    end
    pause(0.25)
end