/**
 * @file cleaner.cpp
 * @author Camille BERNOT (camil.bernot.cb@gmail.com)
 * @brief Clean a file by replacing pipes by spaces in the EcritureLib tag.
 * @version 0.1
 * @date 2024-06-26
 * 
 * @copyright Copyright (c) 2024
 * 
 */

#include <fstream>
#include <iostream>
#include <string>

/**
 * @brief Find the position of the first character of EcritureLib in the line.
 * @details EcritureLib starts at the 10th pipe in the line. Feel free to change the value of pipe_index to find the position of another tag or if the format of the file changes.
 * 
 * @param line
 * @return int (-1 if not found, else the position of the first character of EcritureLib in the line) 
 */
int find_ecriture_lib_start(std::string line)
{
	int pipe_index = 0;
	int pos_ecriture_lib_start = 0;
	for (size_t i = 0; i < line.size(); i++)
	{
		if (line[i] == '|')
			pipe_index++;
		if (pipe_index == 10)
		{
			pos_ecriture_lib_start = i + 1;
			break;
		}
	}
	if (pipe_index != 10)
		return -1;
	return pos_ecriture_lib_start;
}

/**
 * @brief Find the position of the last character of EcritureLib in the line.
 * @details EcritureLib ends at the 7th pipe from the end of the line. Feel free to change the value of pipe_index to find the position of another tag or if the format of the file changes.
 * 
 * @param line
 * @return int (-1 if not found, else the position of the last character of EcritureLib in the line) 
 */
int find_ecriture_lib_end(std::string line)
{
	int pipe_index = 0;
	int pos_ecriture_lib_end = 0;
	for (int i = line.size() - 1; i >= 0; i--)
	{
		if (line[i] == '|')
			pipe_index++;
		if (pipe_index == 7)
		{
			pos_ecriture_lib_end = i;
			break;
		}
	}
	return pos_ecriture_lib_end;
}

/**
 * @brief Replace pipes by spaces in the line between start and end.
 * 
 * @param line The line to modify.
 * @param start Index of the first character to modify.
 * @param end Index of the last character to modify.
 * @return std::string The line with pipes replaced by spaces between start and end.
 */
std::string replace_pipes_by_spaces(std::string line, int start, int end)
{
	for (int i = start; i < end; i++)
	{
		if (line[i] == '|')
			line[i] = ' ';
	}
	return line;
}

/**
 * @brief Find EcritureLib in the line, replace pipes by spaces between the start and end of EcritureLib and write the modified line in the output file.
 * 
 * @param line Line to process.
 * @param output Output file.
 * @return int (-1 if an error occurs, else 0)
 */
int find_ecriture_lib(std::string line, std::ofstream &output)
{
	std::string tags[] = {"JournalCode", "JournalLib", "EcritureNum", "EcritureDate", "CompteNum", "CompteLib", "CompAuxNum", "CompAuxLib", "PieceRef", "PieceDate", "EcritureLib", "Montant", "Sens", "EcritureLet", "DateLet", "ValidDate", "Montantdevise", "Idevise"};

	int pos_ecriture_lib_start = find_ecriture_lib_start(line);
	int pos_ecriture_lib_end = find_ecriture_lib_end(line);
	if (pos_ecriture_lib_start == -1 || pos_ecriture_lib_end == -1)
		return -1;
	output << replace_pipes_by_spaces(line, pos_ecriture_lib_start, pos_ecriture_lib_end) << std::endl;
	return 0;
}

/**
 * @brief Get the name of the clean file.
 * 
 * @param filename Name of the original file.
 * @return std::string Name of the correspondant clean file.
 */
std::string get_clean_filename(std::string filename)
{
	int pos = filename.find_last_of(".");
	std::string clean_filename = filename.substr(0, pos) + "_clean" + filename.substr(pos);
	return clean_filename;
}

int main(int argc, char **argv)
{
	if (argc != 2)
	{
		std::cerr << "Usage: " << argv[0] << " <filename>" << std::endl;
		return 1;
	}
	std::ifstream file(argv[1]);
	std::string output_filename = get_clean_filename(argv[1]);
	std::ofstream output(output_filename);
	if (!file.is_open())
	{
		std::cerr << "Could not open file: " << argv[1] << std::endl;
		return 1;
	}
	std::string line;
	while (std::getline(file, line))
	{
		if (find_ecriture_lib(line, output) == -1)
		{
			std::cerr << "Error: could not find EcritureLib in line" << std::endl;
			return 1;
		}
	}
	output.close();
	file.close();
	std::cout << "Clean file " << output_filename << " created!" << std::endl;
	return 0;
}