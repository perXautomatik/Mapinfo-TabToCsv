$mbxs = (import-csv .\2017-2018.csv -Delimiter ";" -Encoding UTF7)

$stats = foreach ($mbx in $mbxs) {

    $str = $mbx.�rendenummer
    $str = $str.replace('/','_')
  
    $savepath = "C:\Users\crbk01\Desktop\anteckningar w3\2010-2011\" + $str + "_" + $mbx.L�pnummer + ".txt"
   $mbx.information | out-file -filepath $savepath -force

}
