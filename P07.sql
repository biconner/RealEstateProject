

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

SELECT listingID, ApprovalNo INTO vListingID, vApprovalID
FROM Offers
WHERE vOfferID = Offers.OfferID;

SELECT propertyID INTO vPropertyID
FROM Listings
WHERE vListingID = listingID;

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

UPDATE Offers 
SET status = 'accepted'
WHERE OfferID = vOfferID;

COMMIT;

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

--CREATE OR REPLACE PROCEDURE Trade (v1Offer_ID Offers.Offer_ID%TYPE, v2Offer_ID Offers.Offer_ID%TYPE)

BEGIN
    purchase(4);
END;