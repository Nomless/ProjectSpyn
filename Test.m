
brick.SetColorMode(3, 2);
brick.beep();

while 1
    pressed = brick.TouchPressed(1);
    disp(brick.TouchPressed(1));
    if isnan(pressed)
        disp("nan");
    elseif pressed
        brick.beep();
    end
    pause(0.25)
end