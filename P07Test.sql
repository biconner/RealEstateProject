

--purchase with one buyer
BEGIN
    purchase(1);
    COMMIT;
end;

--purchase with two buyers
BEGIN
    purchase(2);
    COMMIT;
end;

--purchase with three buyers
BEGIN
    purchase(3);
    COMMIT;
end;

--trade with two single buyers
BEGIN
    trade(4, 5);
end;

--trade with multiple buyers
BEGIN
    trade(6, 8);
end;

--No data found purchase
BEGIN
    purchase(50);
    COMMIT;
end;

--No data found trade
BEGIN
    trade(50,51);
end;

