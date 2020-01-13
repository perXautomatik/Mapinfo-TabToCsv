CREATE VIEW[dbo]. [vwTrEaAvloppsanlaeggningPunkter]
AS
SELECT
K.recKoordinatID AS Id,
    T.recTillsynsobjektID AS Tillsynsobjekt,
    A.datBesiktningsdatum As Besiktningsdatum,
    A.datBeslutsdatum AS Beslutsdatum,
    A.strVatten AS Vatten,
    A.strInventering AS Inventering,
    A.strBedoemning AS Bedömning,
    A.strStatus AS Status,
    A.strEfterfoeljandereningRecipient AS Recipient,
    T.strAnteckning AS Anteckning,
    [geometry]::Point(K.decY, K.decX, 3015) AS Shape
FROM EDPVisionRegionGotlandAvlopp.dbo.tbTrEaAvloppsanlaeggning AS A
INNER JOIN EDPVisionRegionGotlandAvlopp.dbo.tbTrTillsynsobjekt AS T ON A.recTillsynsobjektID = T.recTillsynsobjektID
INNER JOIN EDPVisionRegionGotlandAvlopp.dbo.tbTrTillsynsobjektKoordinat AS TK ON T.recTillsynsobjektID = TK.recTillsynsobjektID
INNER JOIN EDPVisionRegionGotlandAvlopp.dbo.tbVisKoordinat AS K ON TK.recKoordinatID = K.recKoordinatID
WHERE K.decX IS NOT NULL AND K.decY IS NOT NULL AND K.strPunkttyp = 'Ansluten byggnad'

----------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW [dbo].[vwTrEaAvloppsanlaeggningPunkter]
AS 
SELECT 
K.recKoordinatID AS Id,
T.recTillsynsobjektID AS Tillsynsobjekt,
A.datBesiktningsdatum As Besiktningsdatum,
A.datBeslutsdatum AS Beslutsdatum, 
A.strVatten AS Vatten,
A.strInventering AS Inventering,
A.strBedoemning AS Bedömning,
A.strStatus AS Status,
A.strEfterfoeljandereningRecipient AS Recipient,
T.strAnteckning AS Anteckning,
[geometry]::Point(K.decY, K.decX, 3015) AS Shape
FROM EDPVisionRegionGotlandAvlopp.dbo.tbTrEaAvloppsanlaeggning AS A
INNER JOIN EDPVisionRegionGotlandAvlopp.dbo.tbTrTillsynsobjekt AS T ON A.recTillsynsobjektID = T.recTillsynsobjektID
INNER JOIN EDPVisionRegionGotlandAvlopp.dbo.tbTrTillsynsobjektKoordinat AS TK ON T.recTillsynsobjektID = TK.recTillsynsobjektID
INNER JOIN EDPVisionRegionGotlandAvlopp.dbo.tbVisKoordinat AS K ON TK.recKoordinatID = K.recKoordinatID
WHERE K.decX IS NOT NULL AND K.decY IS NOT NULL AND K.strPunkttyp='Ansluten byggnad'
