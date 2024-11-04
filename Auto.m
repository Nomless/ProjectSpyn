TOUCH_PORT = 4;
ULTRASONIC_PORT = 1;
GYRO_PORT = 2;
COLOR_PORT = 3;
LEFT_DRIVE_MOTOR = 'D';
RIGHT_DRIVE_MOTOR = 'C';
ARM_MOTOR = 'B';

% 2 - Blue
% 3 - Green
% 4 - Yellow
% 5 - Red
STOP_COLOR = 5;

DRIVE_SPEED = 50;
LEFT_OFFSET = -1;
TURN_SPEED = 80;

touched = false;

function ret = GetColor(brick, port)
    rgb = brick.ColorRGB(port);
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

function ret = Turn(brick, gyro_port, left_port, right_port, target)
    % target angle is cw+
    angle = brick.GyroAngle(gyro_port);
    if isnan(angle)
        angle = 0;
    end
    error = target - angle;
    p = 300;
    t = 0;
    while abs(error) > 1 && t <= 2
        angle = brick.GyroAngle(2);
        error = target - angle;
        n_error = error / 360;
        out = clip(p * n_error, -100, 100);
        brick.MoveMotor(left_port, out);
        brick.MoveMotor(right_port, -out);
        t = t + 0.1;
        pause(0.1);
    end
    brick.StopMotor(left_port);
    brick.StopMotor(right_port);
    brick.GyroCalibrate(gyro_port);
end

brick.GyroCalibrate(GYRO_PORT);
brick.SetColorMode(3, 4);

brick.beep();

brick.MoveMotor(LEFT_DRIVE_MOTOR, DRIVE_SPEED + LEFT_OFFSET);
brick.MoveMotor(RIGHT_DRIVE_MOTOR, DRIVE_SPEED);

while 1
    if isnan(brick.TouchPressed(TOUCH_PORT))
        disp("NaN???");
        continue
    end
    if ~touched && brick.TouchPressed(TOUCH_PORT)
        disp("Touching wall");
        touched = true;
        brick.MoveMotor(LEFT_DRIVE_MOTOR, -DRIVE_SPEED);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, -DRIVE_SPEED);
        pause(0.5);
        brick.StopMotor(LEFT_DRIVE_MOTOR);
        brick.StopMotor(RIGHT_DRIVE_MOTOR);
        continue;
    end
    distance = brick.UltrasonicDist(ULTRASONIC_PORT)
    if touched
        % move right
        Turn(brick, GYRO_PORT, LEFT_DRIVE_MOTOR, RIGHT_DRIVE_MOTOR, 90);
        touched = false;
        pause(0.5);
        brick.MoveMotor(LEFT_DRIVE_MOTOR, DRIVE_SPEED + LEFT_OFFSET);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, DRIVE_SPEED);
    elseif GetColor(brick, COLOR_PORT) == STOP_COLOR
        brick.StopMotor(LEFT_DRIVE_MOTOR);
        brick.StopMotor(RIGHT_DRIVE_MOTOR);
        pause(2);
        brick.MoveMotor(LEFT_DRIVE_MOTOR, DRIVE_SPEED + LEFT_OFFSET);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, DRIVE_SPEED);
        pause(0.5);
    elseif distance > 40
        %pause(0.);
        % move left
        %brick.MoveMotor(LEFT_DRIVE_MOTOR, -DRIVE_SPEED);
        %brick.MoveMotor(RIGHT_DRIVE_MOTOR, -DRIVE_SPEED);
        %pause(0.25);
        Turn(brick, GYRO_PORT, LEFT_DRIVE_MOTOR, RIGHT_DRIVE_MOTOR, -90);
        pause(0.5);
        brick.MoveMotor(LEFT_DRIVE_MOTOR, DRIVE_SPEED + LEFT_OFFSET);
        brick.MoveMotor(RIGHT_DRIVE_MOTOR, DRIVE_SPEED);
        for i = 1:25
            if GetColor(brick, COLOR_PORT) == STOP_COLOR
                brick.StopMotor(LEFT_DRIVE_MOTOR);
                brick.StopMotor(RIGHT_DRIVE_MOTOR);
                pause(2);
                brick.MoveMotor(LEFT_DRIVE_MOTOR, DRIVE_SPEED + LEFT_OFFSET);
                brick.MoveMotor(RIGHT_DRIVE_MOTOR, DRIVE_SPEED);
                break;
            end
            pause(0.1);
        end
    end
    
    pause(0.1);
end