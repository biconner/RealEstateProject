

CREATE OR REPLACE PROCEDURE purchase (vOfferID Offers.OfferID%TYPE)
IS
vListingID Listings.listingID%TYPE;
vPropertyID Listings.PropertyID%TYPE;
vApprovalID PreApprovals.PreApprovalID%TYPE;
cCustID Customers.CustID%TYPE;

CURSOR cBuyers IS
        SELECT CustID FROM Preapprovals
        WHERE PreapprovalID = vApprovalID;

BEGIN

SELECT Offers.listingID, Offers.ApprovalNo, Listings.propertyID INTO vListingID, vApprovalID, vPropertyID
FROM Offers INNER JOIN Listings
ON Offers.ListingID = Listings.listingID
WHERE vOfferID = Offers.OfferID;

UPDATE Offers
SET status = 'accepted'
WHERE OfferID = vOfferID;

OPEN cBuyers;
        LOOP
            FETCH cBuyers INTO cCustID;
            EXIT WHEN cBuyers%NOTFOUND;
            INSERT INTO Purchases(CustID, PropertyID, PurchaseDate) VALUES(cCustID, vPropertyID, SYSDATE);
        END LOOP;
    CLOSE cBuyers;

UPDATE Listings
SET status = 'closed'
WHERE listingID = vListingID;

EXCEPTION
 WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Too Many Rows: ' || sqlerrm);
        ROLLBACK;
 WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND: ' || sqlerrm);
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Transfer failed: ' || sqlerrm);
        ROLLBACK;
END;

CREATE OR REPLACE PROCEDURE Trade (v1OfferID Offers.OfferID%TYPE, v2OfferID Offers.OfferID%TYPE)
IS
BEGIN
    purchase(v1OfferID);
    purchase(v2OfferID);
    COMMIT;
END;

