

define(SPHT_IMPL,

  SPHT_Entry_$1_$2::SPHT_Entry_$1_$2()
  {
     is_used = 0;
  }
 

  SPHT_$1_$2::SPHT_$1_$2()
  {
     this.clear();
  }

  void SPHT_$1_$2::resetIterator()
  {
    iterator_pos = 0;
    iterator_next = NULL;
  }

  void SPHT_$1_$2::clear()
  {
     numberOfEntries = 0;
     _elements = new SPHT_Entry_$1_$2[3];
  }

  int SPHT_$1_$2::nextElem(&$1 key,&$2 value)
  {
     var $5 ak;
     var $6 av;
     if( iterator_next != NULL )
     {
         ak.assign(key,iterator_next.key);
         av.assign(value,iterator_next.value);
         iterator_next = iterator_next.next;
     }
     else
     {
        var int found = 0;
        while( (iterator_pos < _elements.sz) && (found == 0) )
        { 
           if( _elements[iterator_pos].is_used == 0) 
           {
              iterator_pos++;
           }
           else
           {
             found = 1;
           }
   
        }
        if( iterator_pos == _elements.sz)
        {
           return 0;
        }
        ak.assign(key,_elements[iterator_pos].key);  
        av.assign(value,_elements[iterator_pos].value);  
        iterator_next = _elements[iterator_pos].next; 
     
        iterator_pos++;
     }
     return 1;
  }

  int SPHT_$1_$2::size()
  {
     return numberOfEntries;
  }

  void SPHT_$1_$2::insertInternally(*SPHT_Entry_$1_$2 bins[],
                                                    &$1 key,
                                                    &$2 value)
  {


      var $3 hac;
      var $4 coac;
      var $5 ak;
      var $6 av;
      var int hc = hac.hash(key);
      var int m1 = -1;
      if( hc < 0 )
      {
        hc = hc * m1;
      } 
      var int pos = hc % bins.sz;


      if( (bins[pos].is_used != 0) && (coac.compare(bins[pos].key,key) == 0) )
      {
          var SPHT_Entry_$1_$2* entry = bins[pos].next;
          if( entry == NULL )
          {
             bins[pos].next = new SPHT_Entry_$1_$2;
             bins[pos].next.is_used = 1;
             ak.assign(bins[pos].next.key,key);
             av.assign(bins[pos].next.value,value);
          }
          else
          {
             var int inserted = 0;
             while( (inserted == 0) && (coac.compare(entry.key,key) == 0))
             {
                  if( entry.next == NULL )
                  {
                     entry.next = new SPHT_Entry_$1_$2;
                     entry.next.is_used = 1;
                     ak.assign(entry.next.key,key);
                     av.assign(entry.next.value,value);
                     inserted = 1;
                  }
                  else
                  {
                     entry = entry.next;
                  }
             }
             if( inserted == 0 )
             {
                ak.assign(entry.key,key);
                av.assign(entry.value,value);
             }
          }
      }
      else
      {
         bins[pos].is_used = 1;
         ak.assign(bins[pos].key,key);
         av.assign(bins[pos].value,value);
      }
  }

  int SPHT_$1_$2::search(&$1 key,&$2 value)
  {
      var $3 hac;
      var $4 coac;
      var $5 ak;
      var $6 av;
      var int hc = hac.hash(key);
      var int m1 = -1;
      if( hc < 0 )
      {
        hc = hc * m1;
      } 
      var int pos = hc % _elements.sz;

      if(_elements[pos].is_used == 1)
      {
          if(coac.compare(key,_elements[pos].key) == 1)
          {
              av.assign(value,_elements[pos].value); 
              return 1;
          }
          else
          {
             var SPHT_Entry_$1_$2* entry = _elements[pos].next;
             while( entry != NULL )
             {
                if( coac.compare(entry.key,key) == 1 )
                {
                   av.assign(value,entry.value);
                   return 1;
                }
                entry = entry.next;
             }
             return 0;
          }
      }
      return 0;    
  }

  void SPHT_$1_$2::insert(&$1 key,&$2 value)
  {
      if( numberOfEntries < 200000000 )
      {
         var int nep1 = numberOfEntries + 1;
         var int limit = ((_elements.sz * 7) / 10);
         if( nep1  > limit )
         {
            var int newCap = (_elements.sz + 1) * 2;
            var *SPHT_Entry_$1_$2 newElements[] = new SPHT_Entry_$1_$2[newCap];

            var $1 key2;
            var $2 value2;
            this.resetIterator();
            while(this.nextElem(key2,value2) )
            {
               this.insertInternally(newElements,key2,value2); 
            }
            _elements = newElements;
         }
         this.insertInternally(_elements,key,value);
         numberOfEntries++;
      }
  }

  void SPHT_$1_$2::del(&$1 key)
  {
      var $3 hac;
      var $4 coac;
      var $5 ak;
      var $6 av;
      var int hc = hac.hash(key);
      var int m1 = -1;
      if( hc < 0 )
      {
        hc = hc * m1;
      } 
      var int pos = hc % _elements.sz;

      if(_elements[pos].is_used == 1)
      {
          if( coac.compare(_elements[pos].key,key) == 0 )
          {
              var SPHT_Entry_$1_$2* entry = _elements[pos].next;
              if( (entry != NULL) && (coac.compare(entry.key,key) == 1))
              {
                 _elements[pos].next = entry.next;
                 numberOfEntries = numberOfEntries - 1;
              }
              else
              {
                 var SPHT_Entry_$1_$2* previousEntry;
                 do
                 {
                    previousEntry = entry; 
                    entry=entry.next;
                 }
                 while( (entry != NULL) && (coac.compare(entry.key,key) == 0)  );

                 if(entry != NULL)
                 {
                     previousEntry.next = entry.next; 
                     numberOfEntries = numberOfEntries - 1;
                 }
              }
          }
          else
          {
              if( _elements[pos].next != NULL)
              {
                 var SPHT_Entry_$1_$2* entryNext = _elements[pos].next;
                 ak.assign(_elements[pos].key,entryNext.key);
                 av.assign(_elements[pos].value,entryNext.value);
                 _elements[pos].next = entryNext.next;
              }
              else
              {
                 _elements[pos].is_used = 0;   
              }
              numberOfEntries = numberOfEntries - 1;
          }
      } 
  }
)

SPHT_IMPL(String_16,String_16,Hash_String_16,Compare_String_16,Assigner_String_16,Assigner_String_16)
