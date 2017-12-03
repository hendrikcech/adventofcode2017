#include <stdio.h>

int partOne(const char*path){
  FILE *file;
  char temp;
  int resInt=0;

  int counter =0;

  file=fopen(path,"r");

  while (((temp = fgetc(file)) != EOF) && temp !='\n') {
    counter += 1;
  }
  fseek(file, 0, SEEK_SET);

  int values[counter];
  counter=0;
  int tempInt = 0;

  while (((temp = fgetc(file)) != EOF) && temp !='\n') {
    tempInt=temp-'0';
    values[counter]=tempInt;
    counter += 1;
  }

  for (size_t i = 0; i < counter ; i++) {
    if (values[i] == values[(i+1)%counter]) {
      resInt += values[i];
    }
  }
  printf("%s%d\n","Result for part one: ", resInt);
  fclose(file);
}

int partTwo(const char* path){
  FILE *file;
  char temp;
  int resInt=0;

  int counter =0;

  file=fopen(path,"r");

  while (((temp = fgetc(file)) != EOF) && temp !='\n') {
    counter += 1;
  }
  fseek(file, 0, SEEK_SET);

  int values[counter];
  counter=0;
  int tempInt = 0;

  while (((temp = fgetc(file)) != EOF) && temp !='\n') {
    tempInt=temp-'0';
    if(tempInt<1 || tempInt > 9) continue;
    values[counter]=tempInt;
    counter += 1;
  }
  printf("%s%d\n", "Elements: ", counter);

  for (size_t i = 0; i < counter ; i++) {
    if (values[i] == values[(i+(counter/2))%(counter)]) {
      resInt += values[i];
    }
  }
  printf("%s%d\n", "Result for part two: ", resInt);
  fclose(file);
}

int main(int argc, char const *argv[]) {

  partOne(argv[1]);
  partTwo(argv[1]);
  return 0;
}
