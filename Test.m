
brick.SetColorMode(3, 4);

function ret = GetColor(brick, port)
    rgb = brick.ColorRGB(port)
    red = rgb(1);
    green = rgb(2);
    blue = rgb(3);
    if red > 100
        if green > 80
            ret = 4;
        else
            ret = 5;
        end
    elseif green > 80
        ret = 3;
    elseif blue > 150
        ret = 2;
    else
        ret = 0;
    end
end

LEFT_DRIVE_MOTOR = 'D';
RIGHT_DRIVE_MOTOR = 'C';

brick.GyroCalibrate(2);
brick.beep();

angle = brick.GyroAngle(2);
if isnan(angle)
    angle = 0
end
error = -90 - angle
p = 250;
while abs(error) > 1
    angle = brick.GyroAngle(2)
    error = -90 - angle
    n_error = error / 360;
    out = clip(p * n_error, -100, 100)
    brick.MoveMotor(LEFT_DRIVE_MOTOR, out);
    brick.MoveMotor(RIGHT_DRIVE_MOTOR, -out);
    pause(0.1);
end
pause(0.75);
brick.StopMotor(LEFT_DRIVE_MOTOR);
brick.StopMotor(RIGHT_DRIVE_MOTOR);

while 1
    %pressed = brick.TouchPressed(1);
    %disp(GetColor(brick, 3));
    disp(brick.GyroAngle(2));
    
    %if isnan(pressed)
    %    disp("nan");
    %elseif pressed
    %    brick.beep();
    %end
    pause(0.25)
end