
-- Offer with single buyer
BEGIN
    CreateOffer(5, 4, 350000, '19-Jul-2021');
END;

--Offer with two buyers
BEGIN
    CreateOffer(10, 7, 350000, '19-Jul-2021');
END;

--Offer with three buyers
BEGIN
    CreateOffer(12, 9, 2999999, '21-Jul-2021');
END;

--Offer amount that exceeds the approval amount and throws error
BEGIN
    CreateOffer(11, 6, 4000000000, '20-Jul-2021');
END;

--No Data Found
BEGIN
    CreateOffer(8, 10, 14500000, '20-Jul-2021');
END;

-- Update offer amount that will execute
UPDATE Offers SET OfferAmount = 1000000 WHERE OFFERID = 4;
COMMIT;

-- Update offer amount that will raise error
UPDATE Offers SET OfferAmount = 2000000 WHERE OFFERID = 4;
COMMIT;