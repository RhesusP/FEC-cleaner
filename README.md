<div align="center">

# FEC_cleaner

#### Why isn't this file standardized?

<br />
<br />
<img src="https://42f2671d685f51e10fc6-b9fcecea3e50b3b59bdc28dead054ebc.ssl.cf5.rackcdn.com/illustrations/export_files_re_99ar.svg" height=300>
<br />
<br />
</div>
<br />

## About

This project is a small program that simplifies the import of a FEC file (Fichier des Écritures Comptables for French accounting) into Excel.

## How does it work?

When a company exports its accounting data, it is usually in the form of a FEC file. This FEC file is structured like a CSV file with a `|` separator.
The problem is that a lot of companies use the character `|` in the field `EcritureLib`, which makes it difficult to import the FEC file into Excel.

So, the program reads the input file line by line and replaces the `|` character in the `EcritureLib` field with a space character (` `). It then writes this data to the output file.


## How to use

```bash
make
./FEC_cleaner <input_file>
```

Then, the program will generate a file named `<filename>_clean.txt` that contains the cleaned data and which can be imported into Excel.

> [!IMPORTANT]  
> Legally, the FEC must contain mandatory fields, but the order of these fields is not standardized. This program assumes that the FEC file is structured as follows:
> `JournalCode|JournalLib|EcritureNum|EcritureDate|CompteNum|CompteLib|CompAuxNum|CompAuxLib|PieceRef|PieceDate|EcritureLib|Montant|Sens|EcritureLet|DateLet|ValidDate|Montantdevise|Idevise
`
> Depending on the software used to export the FEC file, the order of the fields may be different. In this case, you will need to update start and end indexes in the `FEC_cleaner.cpp` file (functions `find_ecriture_lib_start` and `find_ecriture_lib_end`).

## License

This project is licensed under the PolyForm Noncommercial License 1.0.0 - see the [LICENSE.md](LICENSE.md) file for details.