define(StringGen,
    class dllexport_a String_$1
    {
        char _preAllocBuf[$1];
        *char _extendedBuf[];
        int _length;

    methods:

        String_$1();
        String_$1(&char init[]);
        String_$1(&String_$1 other);
        void print();
        void printNoLF();
        void append(&char str[]);
        void append(&char str[],int pos,int anzahl);
        void append(*char buf[]);
        void append(&String_$1 other);
        void append(String_$1* other);
        void append(char c);
        void append(int x);
        void append(double d);
        void append(longlong l);
        void appendKurz(double d);
        void appendHexOctet(int x);
        void appendHex(longlong x);
        thisreturn void append(longlong x,int base);

        void assign(&char str[]);
        void assign(char zeichen);

        void assign(&String_$1 anderer);
        void assign(String_$1* anderer);
 
        char getAt(int x);
        void setAt(int stelle, char zeichen);

        int capacity();
        int length();
        void clear();
        void clearAndReclaimMemory();
        int lengthOf(&char str[]);

        int compare(&char str[]);

        int compare(&String_$1 other);
   

        thisreturn void getKey(String_$1* key);

        int getHashCode();


        void getExtendedBuf(*char extendedBuf[]);

        int equals(&String_$1 other);

        int equals(&char other[]);

        void toCharArray(&char feld[]);

        int asNumber();

        int asNumber(int radix);

        longlong asNumberLL(int radix);

        double asDouble();

        void escape(&String_$1 escaped,char escape);

        void deEscape(&String_$1 deescaped,char escape);

        int endsWith(&char end[]);

        int endsWith(&String_$1 str2);

        void rightOf(char divider,&String_$1 oStr);

        int startsWith(&char buf[]);

        void subString(&String_$1 oStr,int start, int end);

        ~String_$1();

        static int isNumberChar(char c);

        int hashCode();

        longlong hashCodeLL();

        void ersetzen(&String_$1 alt,&String_$1 neu,&String_$1 ergebnis);

        void unitTest();

        int teileAuf(*String_$1 spalten[],char trenner);

        void wandleKleinbuchstaben();

        void wandleUmlaute(&String_$1 ziel );
       
        void ensureCapacity(int minCapacity);

        

        //int contains(&String substring);
    };

    //Adapter Class for Hashing with SPHT
    class Hash_String_$1
    {
       methods:
         static int hash(&String_$1 str);
    };

    //Adapter class for comparison in SPHT
    class Compare_String_$1
    {
       methods:
         static int compare(&String_$1 s1,&String_$1 s2);
    };

    class Assigner_String_$1
    {
      methods:
         static void assign(&String_$1 s1,&String_$1 s2);
    };
)


StringGen(16)
StringGen(128)
