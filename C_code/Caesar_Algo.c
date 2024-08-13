#include<stdio.h>
#include<string.h>

// Function to encrypt the input string.
void Encrypt(char text[], int shift)
{
    for(int i =0; i < strlen(text); i++)
    {
        if(text[i] >= 'a' && text[i] <= 'z')
        {
            text[i] = ((text[i] - 'a' + shift) % 26) + 'a';
        }
        if(text[i] >= 'A' && text[i] <= 'Z')
        {
            text[i] = ((text[i] - 'A' + shift) % 26) + 'A';
        }
    }
}

// Function to decrypt the encrypted string.
void Decrypt(char text[], int shift)
{
    Encrypt(text, 26 - shift);
}

int main(void)
{
    char text[100] = "HelloWorld";
    int shift = 4;

    printf("Message before encryption: %s\n",text);

    Encrypt(text,shift);
    printf("Message after encryption: %s\n",text);

    Decrypt(text,shift);
    printf("Message after decryption: %s\n",text);

    return 0;
}