global key
InitKeyboard();

while 1
    pause(0.1);
    switch key
        case 'w'
            disp("Up");
            brick.MoveMotor(LEFT_MOTOR, -speed);
            brick.MoveMotor(RIGHT_MOTOR, -speed);
        case 'a'
            disp('left');
            brick.MoveMotor(LEFT_MOTOR, speed);
            brick.MoveMotor(RIGHT_MOTOR, -speed);
        case 's'
            disp("down");
            brick.MoveMotor(LEFT_MOTOR, speed);
            brick.MoveMotor(RIGHT_MOTOR, speed);
        case 'd'
            disp('right');
            brick.MoveMotor(LEFT_MOTOR, -speed);
            brick.MoveMotor(RIGHT_MOTOR, speed);
        case 'q'
            disp('right');
            brick.MoveMotor(LEFT_MOTOR, -speed/2);
            brick.MoveMotor(RIGHT_MOTOR, -speed);
        case 'e'
            disp('right');
            brick.MoveMotor(LEFT_MOTOR, -speed);
            brick.MoveMotor(RIGHT_MOTOR, -speed/2);
        case 'uparrow'
            speed = speed + 10
        case 'downarrow'
            speed = speed - 10
        case 0
            brick.StopMotor(LEFT_MOTOR);
            brick.StopMotor(RIGHT_MOTOR);
        case 'p'
            break;
    end
end
brick.StopMotor(LEFT_MOTOR);
brick.StopMotor(RIGHT_MOTOR);
CloseKeyboard();