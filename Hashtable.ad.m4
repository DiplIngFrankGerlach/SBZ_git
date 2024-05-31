

/***
* Sappeur Hashtable 
*
* Key-Value Style
  Keys and Values are stored as values, not pointers (may use pointers internally (RAII etc), though)
  keys must implement getHashCode() and equals()

  keyType type of the key entry
  valueType type of the value entry
  hashAC Hash Adapter Class
  compareAC Comparison Adapter Class
*/

define(SPHT,

    class dllexport_a SPHT_Entry_$1_$2
    {
         $1 key;
         $2 value;
         SPHT_Entry_$1_$2 * next;
         int is_used; 
        methods:
         SPHT_Entry_$1_$2();

    };
    
    class dllexport_a SPHT_$1_$2
    {
         *SPHT_Entry_$1_$2 _elements[];
         int numberOfEntries;
         int iterator_pos;
         SPHT_Entry_$1_$2* iterator_next; 
       methods:
         SPHT_$1_$2();         

         void insert(&$1 key,&$2 value);

         int search(&$1 key,&$2 value);

         void del(&$1 key);

         static void insertInternally(*SPHT_Entry_$1_$2 bins[],
                                      &$1 key,
                                      &$2 value);
                    
         void resetIterator();

         int nextElem(&$1 key,&$2 value);

         int size();

         void clear();
    };
    
)


SPHT(String_16,String_16,Hash_String_16,Compare_String_16,Assigner_String_16,Assigner_String_16)


