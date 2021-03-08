AlphaTest[x_] := 0 <= x <= 25;

TextCode[text_] := Select[
                       ToCharacterCode[
                             ToUpperCase[text]] - 65, AlphaTest];

FromCode[textcode_] := FromCharacterCode[textcode + 65];

message = Import["http://www.repubblica.it"];
Italian = Import["http://www.corriere.it"];
English = Import["http://www.nytimes.com"];

pita = Table[N@Count[XN2, i]/Length[XN2], {i, 0, 25}];
peng = Table[N@Count[XN3, i]/Length[XN3], {i, 0, 25}];

LanguageCoincidenceIndex[distribution_]:= Plus@@(distribution^2)

IcITA=LanguageCoincidenceIndex@pita;
IcENG=LanguageCoincidenceIndex@peng;




CoincidenceIndex[textcode_] :=
 N[Plus @@
    Map[#[[2]] (#[[2]] - 1) &,
     Tally[textcode]]/(Length[textcode] (Length[textcode] - 1))];

MutualCoincidenceIndex[textcode_, distribution_] := Plus @@ Table[
   N@Count[textcode, i] distribution[[i + 1]]/Length[textcode], {i, 0,
     25}];
     
m = 26
ShiftEncode[x_, k_] := Mod[x + k, m];
ShiftDecode[x_, k_] := ShiftEncode[x, -k];


TextEncryption[encryptionfunction_, key_, text_] :=
 Module[{encoding},
  (
       encoding[x_] := encryptionfunction[x, key];
       Map[encoding, text]
   )]

TextDecryption[decryptionfunction_, key_, text_] :=
 Module[{encoding},
  (
       encoding[x_] := decryptionfunction[x, key];
       Map[encoding, text]
   )]

