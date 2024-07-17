


define(StringsImpl, 
        
        String_$1::String_$1(&char init[])
        {
           _length=0;
           _preAllocBuf[0] = '\0';
           this.append(init);
        }

        String_$1::String_$1(&String_$1 other)
        {
           _length=0;
           _preAllocBuf[0] = '\0';
           this.append(other);
        }

        String_$1::String_$1()
        {
           _length=0;
           _preAllocBuf[0] = '\0';
           this.append("");
        }

        int String_$1::capacity()
        {
           if( _extendedBuf   != NULL)
           {
              return _extendedBuf.sz;
           }
           return _preAllocBuf.sz;
        }
        
        int String_$1::teileAuf(*String_$1  spalten[],char trenner)
        {
            var int stelle=0;
            var int ausgStelle = 0;
            var int l = this.length();
            spalten[0].clear();
            while((ausgStelle < spalten.sz) && (stelle < this.length() ) )
            {
                var char z = this.getAt(stelle);
                if( z == trenner )
                {
                   ausgStelle++;
                   if( ausgStelle < spalten.sz )
                   {
                       spalten[ausgStelle].clear();
                   }
                } 
                else
                {
                    spalten[ausgStelle].append(z);
                }
                stelle++;
            }
            if( stelle == this.length() )
            {
               return 1;
            }
            return 0;
        }

        void String_$1::getKey(String_$1* key)
        {
          key = this;
        }

        // return 1 if strings are equal komma return 0 if not 
        int String_$1::compare(&String_$1 other)
        {
           if( this.length() == other.length() )
           {
              var int l = this.length();
              var int i;
              for(i=0;i < l; i++)
              {
                 if( this.getAt(i) != other.getAt(i) )
                 {
                    return 0;
                 }
              } 
           }
           else 
           { 
              return 0; 
           }

           return 1;
        }
        
        double String_$1::asDouble()
        {
            if(this.length() > 301)
            { 
               var double notAnum;
               inline_cpp[[ notAnum = NAN; ]]
               return notAnum; 
            }

            var double ret;
            var char puffer[301];
            this.toCharArray(puffer);
            inline_cpp[[
               ret=atof(puffer._array);
            ]]
            return ret;
        }

        void String_$1::assign(&char str[])
        {
           this.clear();
           this.append(str);
        }
        void String_$1::assign(char zeichen)
        {
           this.clear();
           this.append(zeichen);
        }

        void String_$1::assign(&String_$1 anderer)
        {
           this.clear();
           this.append(anderer);
        }

        void String_$1::assign(String_$1* anderer)
        {
           this.clear();
           this.append(anderer);
        }


        void String_$1::append(&char buf[])
        {
             var int groesse=0;
             var int nullGefunden = 0;
             while((nullGefunden == 0) && ( groesse < buf.sz) )
             {
                  if(buf[groesse] == '\0') { nullGefunden = 1; }
                  else { groesse++; }
             }

             this.ensureCapacity( _length + groesse );
             var int stelle;
             for(stelle = 0; stelle < groesse; stelle++)
             {
                 this.append(buf[stelle]);
             }
        }
        
        void String_$1::append(&char str[],int pos,int anzahl)
        {
           for(var int i=0;i<anzahl;i++)
           {
              this.append(str[i+pos]);
           }
        }

        void String_$1::append(double d)
        {
            var char puffer[31];
            inline_cpp[[
                snprintf(puffer._array,30,"%.10e",d);
            ]]
            this.append(puffer);
        }

        void String_$1::appendKurz(double d)
        {
            var char puffer[301];
            inline_cpp[[
                snprintf(puffer._array,300,"%3.2lf",d);
            ]]
            this.append(puffer);
        }

        void String_$1::append(longlong l, int basis)
        {
              var String_16 zk16;
              ZKNuetzlich::wandle(l,basis,zk16);
              this.ensureCapacity(_length + zk16.length() );
              for(var int i=0; i < zk16.length(); i++)
              {
                 this.append(zk16.getAt(i));
              }
        }

        int String_$1::length()
        {
           var int i=0;
           return _length;
        }

        void String_$1::print()
        {
           this.printNoLF();
           inline_cpp[[ ::printf("\\n"); ]]
        }

        void String_$1::printNoLF()
        {
            this.ensureCapacity(_length + 1);
            if(_extendedBuf == NULL)
            {
               _preAllocBuf[_length]='\0';
               inline_cpp[[::printf("%s",_preAllocBuf._array);]]
            }
            else
            {
              _extendedBuf[_length]='\0';
               inline_cpp[[::printf("%s",_extendedBuf._theObject->_array);]]
            }
        }

        int String_$1::lengthOf(&char str[])
        {
           var int l=0;
           while(str[l] !='\0')
           {
              l=l+1;
           }
           return l;
        }

        void String_$1::clear()
        {
            _length=0;
            if(_extendedBuf != NULL){_extendedBuf[0]='\0';}
            _preAllocBuf[0]='\0';
        }

        void String_$1::append(&String_$1 other)
        {
             var int groesse=other.length();

             this.ensureCapacity( _length + groesse );
             var int stelle;
             for(stelle = 0; stelle < groesse; stelle++)
             {
                 this.append(other.getAt(stelle));
             }
        }


        void String_$1::clearAndReclaimMemory()
        {
           _length=0;
           _extendedBuf=NULL;
           _preAllocBuf[0]='\0';
          
        }

        // return 1 if strings are equal komma return 0 if not 
        int String_$1::compare(&char str[])
        {
            var int i=0;
            while((i < str.sz) && (str[i] != '\0') && (i < _length) )
            {
               if( this.getAt(i) != str[i] )
               {
                   return 0;
               }
               i++;
            }
            if( i == _length)
            {
               return 1;
            }
            return 0;
        }

        

        void String_$1::append(char c)
        {
           if(_extendedBuf == NULL)
           {
              if( $1 <= _length )
              {
                this.ensureCapacity( _length * 2);
                _extendedBuf[_length] = c;
              }
              else
              {
                 _preAllocBuf[_length] = c; 
              }
              _length++;
           }
           else
           {
               //Es gibt schon einen extendedBuf
               if( _extendedBuf.sz <= _length )
               {
                  this.ensureCapacity( _length * 2);
               }
               _extendedBuf[_length] = c;
               _length++;
           }
           
        }

        char String_$1::getAt(int i)
        {
            if(_extendedBuf != NULL)
            {
               return _extendedBuf[i];
            }
            else
            {
                return _preAllocBuf[i];
            }
            return '\0';//dummy
        }

        void String_$1::setAt(int stelle, char zeichen)
        {
            if(_extendedBuf != NULL)
            {
                _extendedBuf[stelle] = zeichen;
            }
            else
            {
                _preAllocBuf[stelle] = zeichen;
            }
        }

        void String_$1::getExtendedBuf(*char extendedBufRet[])
        {
           extendedBufRet=_extendedBuf;
        }

        String_$1::~String_$1()
        {
            _extendedBuf=NULL;
            _length= - 13;
        }

        void String_$1::rightOf(char divider,&String_$1 oStr)
        {
           var int zeiger = this.length() - 1;
           var int fertig = 0;
           while((zeiger >= 0) && ( fertig == 0))
           {
              var char zeichen = this.getAt(zeiger);
              if( zeichen == divider )
              {
                 fertig = 1;
              } 
              else
              {
                 zeiger=zeiger - 1;
              }  
           }
           oStr.clear();
           for(var int i=zeiger+1;i < this.length(); i++)
           {
              oStr.append(this.getAt(i));
           }
        }

        //ret == 1 if equal; ret==0 if not equal
        int String_$1::equals(&String_$1 other)
        {
           var int equal=0;
           var int l=this.length();
           if(l != other.length())
           {
              return 0;
           }
           for(var int i=0;i < l;i++)
           {
               if(this.getAt(i) != other.getAt(i))
               {return 0;}
           }
           return 1;
        }

        int String_$1::equals(&char other[])
        {
           var int lother=0;
           while((lother<other.sz) && (other[lother] != '\0'))
           {
              lother++;
           }
           if(lother != this.length())
           {return 0;}
           for(var int i=0;i<lother;i++)
           {
              if(this.getAt(i) != other[i])
              {return 0;}
           }
           return 1;
        }

        void String_$1::append(String_$1* other)
        {
            for(var int i=0;i<other.length();i++)
            {
                this.append(other.getAt(i));
            }
        }
        void String_$1::append(int x)
        {
            var longlong xLL = cast(longlong,x);
            this.append(x,10);
        }

        void String_$1::appendHexOctet(int x)
        {
           var char buf[16];
           buf[0]='\0';
           inline_cpp[[ snprintf(buf._array,16,"%.2x",x); ]]
           this.append(buf);
        }

        void String_$1::appendHex(longlong x)
        {
            this.append(x,16);
        }
        void String_$1::append(longlong x)
        {
            this.append(x,10);
        }

        void String_$1::append(*char buf[])
        {
             var int groesse=0;
             var int nullGefunden = 0;
             while((nullGefunden == 0) && ( groesse < buf.sz) )
             {
                  if(buf[groesse] == '\0') { nullGefunden = 1; }
                  else { groesse++; }
             }
             //inline_cpp[[ cout << "groesse: " << groesse << endl;  ]]

             this.ensureCapacity( _length + groesse );
             var int stelle;
             for(stelle = 0; stelle < groesse; stelle++)
             {
                 //inline_cpp[[ cout << "stelle: " << stelle << endl;  ]]
                 this.append(buf[stelle]);
             }
        }



        void String_$1::toCharArray(&char feld[])
        {
            var int szm1=feld.sz - 1;
            if(szm1<this.length())
            {
               feld[0]='\0';
               return;
            }
            var int i=0;
            for(;i<this.length();i++)
            {
               feld[i]=this.getAt(i);
            }
            feld[i]='\0';
        }

        int String_$1::asNumber()
        {
            return this.asNumber(10);
        }

        int String_$1::asNumber(int radix)
        {
            var int ret=0;
            var int isNegative=0;
            var int idx=0;
            if(this.getAt(0)== '-')
            {isNegative=1;idx=1;}

            for(;idx<this.length();idx++)
            {
                var char c=this.getAt(idx);
                switch(c)
                {
                    case '0':case '1':case '2':case '3':case '4':
                    case '5':case '6':case '7':case '8':case '9':
                    {
                      ret=ret*radix;
                      ret=ret+cast(int,c)-cast(int,'0');
                    };break;
                    case 'a':case 'b':case 'c':case 'd':case 'e':case 'f':
                    {
                      ret=ret*radix;
                      ret=ret+cast(int,c)-cast(int,'a')+10;
                    };break;
                    case 'A':case 'B':case 'C':case 'D':case 'E':case 'F':
                    {
                      ret=ret*radix;
                      ret=ret+cast(int,c)-cast(int,'A')+10;
                    };break;
                    default:{idx=this.length();};
                }
            }
            if(isNegative == 1){ret= -1 *ret;}
            return ret;
        }

        longlong String_$1::asNumberLL(int radix)
        {
            var longlong ret=0;
            var int isNegative=0;
            var int idx=0;
            if(this.getAt(0)== '-')
            {isNegative=1;idx=1;}

            for(;idx<this.length();idx++)
            {
                var char c=this.getAt(idx);
                switch(c)
                {
                    case '0':case '1':case '2':case '3':case '4':
                    case '5':case '6':case '7':case '8':case '9':
                    {
                      ret=ret*radix;
                      ret=ret+cast(int,c)-cast(int,'0');
                    };break;
                    case 'a':case 'b':case 'c':case 'd':case 'e':case 'f':
                    {
                      ret=ret*radix;
                      ret=ret+cast(int,c)-cast(int,'a')+10;
                    };break;
                    case 'A':case 'B':case 'C':case 'D':case 'E':case 'F':
                    {
                      ret=ret*radix;
                      ret=ret+cast(int,c)-cast(int,'A')+10;
                    };break;
                    default:{idx=this.length();};
                }
            }
            if(isNegative == 1){ret= -1 *ret;}
            return ret;
        }

        void String_$1::escape(&String_$1 escaped,char escape)
        {
           for(var int i=0;i<this.length();i++)
           {
              var char c=this.getAt(i);
              if(c==escape)
              {
                  escaped.append(escape);
                  escaped.append(escape);
              }
              else
              {
                  escaped.append(c);
              }
           }
        }

        void String_$1::deEscape(&String_$1 deescaped,char escape)
        {
            for(var int i=0;i<this.length();i++)
            {
               var char c=this.getAt(i);
               if(c==escape)
               {
                  i++;
                  deescaped.append(this.getAt(i));
               }
               else
               {
                   deescaped.append(c);
               }
            }
        }

        int String_$1::endsWith(&char end[])
        {
            var int j=0;
            while((end[j] != '\0') && (j<end.sz) ){j++;}
            if(j<=0)
            {
               return  - 1;
            }
            else
            {
              j=j - 1;
            }
            for(var int i=this.length() - 1;
                (i>=0)&&(j>=0);
                i=i - 1,j=j - 1)
            {
                var char c=this.getAt(i);
                if(c != end[j])
                {return 0;}
            }
            return 1;
        }

        int String_$1::endsWith(&String_$1 str2)
        {
            if(str2.length()>this.length()){return 0;}
            var int p=str2.length() - 1;
            var int p2=this.length() - 1;
            for(var int i=p, var int j=p2;i>0;i=i - 1,j=j - 1)
            {
                if(str2.getAt(i)!= this.getAt(j))
                {return 0;}
            }
            return 1;
        }

        int String_$1::startsWith(&char buf[])
        {
           var int l=this.lengthOf(buf);
           var int i=0;
           if(l>this.length()){return 0;}
           while((i<l) && (buf[i] != '\0'))
           {
              if(this.getAt(i) != buf[i])
              {return 0;}
              i++;
           }
           return 1;
        }


        void String_$1::subString(&String_$1 oStr,int start, int end)
        {
           for(var int i=start;i<=end;i++)
           {
              oStr.append(this.getAt(i));
           }
        }
        
        int String_$1::isNumberChar(char c)
        {
            switch(c)
            {
               case '0':case '1':case '2':case '3':
               case '4':case '5':case '6':case '7':
               case '8':case '9':{return 1;};
               default:{return 0;};
            }
            return 0;
        }

        int String_$1::hashCode()
        {
            var longlong h = this.hashCodeLL();
            h = h ^ (h >> 32);
            return cast(int,h);
        }

        longlong String_$1::hashCodeLL()
        {
            var longlong c1 =  0x9876543287654321;

            //PI =            0x3.243f6a8885a308d313198a2e03707344a4093822299f31d0082efa98ec4e6c89
            var longlong cPI  = 0x3243f6a8885a308d;
            var longlong cPI2 = 0x313198a2e0370734;
            var longlong cPI3 = 0xa4093822299f31d0;

            //Euler = 2.7182818284 5904523536 0287471352 6624977572 4709369995 9574966967 6277240766
            //         3035354759 4571382178 5251664274 2746639193 2003059921 8174135966

            var longlong cE1 = 0x2718281828459045;
            var longlong cE2 = 0x5235360287471352;
            var longlong cE3 = 0x6624977572470936;

            var longlong state = cE3;

            var int l = this.length();

            var int ld8 = l / 8;
            var int ld8m8 = ld8 * 8;
            for(var int i=0; i < ld8m8; i = i + 8)
            {
               var longlong  zeichen =
                                   cast(longlong,this.getAt(i    )); zeichen = zeichen << 8;
               zeichen = zeichen + cast(longlong,this.getAt(i + 1)); zeichen = zeichen << 8;
               zeichen = zeichen + cast(longlong,this.getAt(i + 2)); zeichen = zeichen << 8;
               zeichen = zeichen + cast(longlong,this.getAt(i + 3)); zeichen = zeichen << 8;
               zeichen = zeichen + cast(longlong,this.getAt(i + 4)); zeichen = zeichen << 8;
               zeichen = zeichen + cast(longlong,this.getAt(i + 5)); zeichen = zeichen << 8;
               zeichen = zeichen + cast(longlong,this.getAt(i + 6)); zeichen = zeichen << 8;
               zeichen = zeichen + cast(longlong,this.getAt(i + 7));
               //spreize den Input auf 64 bit auf
               zeichen =  (zeichen * c1) ^ (zeichen * cE2) ;
               state = (state ^ zeichen) ;
               var longlong t1 = (state << 17) | (state >> 47);
               var longlong t2 = (state << 34) | (state >> 30);
               var longlong t3 = (state << 44) | (state >> 20);
               state = (state * cPI) ^ ( t1 * cPI2) ^ ( t2 * cPI3) ^ (t3 * cE1);
            }
            var int stelle8 = ld8 * 8;
            for(var int i=stelle8; i < l; i = i + 1)
            {
               var longlong  zeichen = cast(longlong,this.getAt(i)); zeichen = zeichen << 8;
               //spreize den Input auf 64 bit auf
               zeichen =  (zeichen * c1) ^ (zeichen * cE2) ;
               state = (state ^ zeichen) ;
               var longlong t1 = (state << 17) | (state >> 47);
               var longlong t2 = (state << 34) | (state >> 30);
               var longlong t3 = (state << 44) | (state >> 20);
               state = (state * cPI) ^ ( t1 * cPI2) ^ ( t2 * cPI3) ^ (t3 * cE1);
            }
            return state;
        }

        void String_$1::wandleKleinbuchstaben()
        {
            var int i;
            for(i=0; i < this.length(); i++)
            {
               var char z = this.getAt(i);

               if( (z >= 'A') && (z <= 'Z') )
               {
                  var char zNeu = cast(char,((cast(int,z) - cast(int,'A')) + cast(int,'a')) );
                  this.setAt(i,zNeu);
               }
            }
        }

     
        int String_$1::getHashCode()
        {
          return this.hashCode();
        }

        void String_$1::wandleUmlaute(&String_$1 ausgabe)
        {
            var int i=0;
             
            for(i=0; i < _length; i++)
            {
                var char zeichen = this.getAt(i);
                switch( cast(int,zeichen) )
                {
                   case 0xE4: { ausgabe.append("ae"); };break;
                   case 0xFC: { ausgabe.append("ue"); };break;
                   case 0xF6: { ausgabe.append("oe"); };break;
                   default: { ausgabe.append(cast(char,zeichen) ); };
                }
            }
        }
        
        void String_$1::ensureCapacity(int minCapacity)
        {
            if($1 < minCapacity)    
            {
               if( _extendedBuf == NULL ) 
               {
                  _extendedBuf = new char[minCapacity*2];
                  var int i;
                  for(i=0; i < _length; i++)
                  {
                      _extendedBuf[i] = _preAllocBuf[i];
                  }
               }
               else
               {
                   if(_extendedBuf.sz < minCapacity )
                   {
                      
                      var *char newBuf[] = new char[minCapacity*2];
                      var int i;
                      for(i=0; i < _length; i++)
                      {
                           newBuf[i] = _extendedBuf[i];
                      }
                      _extendedBuf = newBuf;
                   }
               }
            } 
        }


        int Hash_String_$1::hash(&String_$1 str)
        {
            return str.getHashCode();
        }

        int Compare_String_$1::compare(&String_$1 s1,&String_$1 s2)
        {
            if(s1.equals(s2) == 1)
            {
              return 1;
            }
            return 0;
        }

        void Assigner_String_$1::assign(&String_$1 s1,&String_$1 s2)
        {
           s1.clear();
           s1.append(s2);
        }

   

)

StringsImpl(16)
StringsImpl(128)
