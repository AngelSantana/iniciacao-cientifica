#!/usr/bin/perl
$INDEX_NOUN = "index.noun";
$DATA_NOUN = "data.noun";
#$DIRETORIO = "D:/Projetos/WordNet/WordNet/dict/";
$DIRETORIO = "C:/WordNet/dict/";
$DISCOVER_DATA = "discover.data";
$DISCOVER_NAMES = "discover.names";
$DIRETORIO_DISCOVER = "C:/WordNet/";
# perl trim function - remove leading and trailing whitespace
sub trim($)
{
  my $string = shift;
  $string =~ s/^\s+//;
  $string =~ s/\s+$//;
  return $string;
}
sub extrairPalavras($){
   ($nome) = $linha2 =~ /(([a-z]){1}\S.*\b\s(@))/ ;
   ($linha2) = $nome =~ /(([a-z]){1}\S.*.([a-z]){1}\b)/;
    return ($linha2);                   
}

sub extrairNomes{
   my $new = $_[0], $palavra;
   
   ($palavra) = $new =~ /^(\"[a-zA-z]+\")/;
   ($new) = $palavra =~ /([a-zA-z]+)/;
   
   return ($new);
   
}

sub buscarSinonimos{
	my $word = trim($_[0]);
	my $number, $data, $linha, $number, $nome, $id, $linha2;
	open(INDEX, $DIRETORIO.$INDEX_NOUN) or die  "Couldn't open file "." ". $INDEX_NOUN,", $!";		
	
	while(<INDEX>){		  
	   if(/^$word /){
		$linha = $_;				
		($number) = $linha =~ /\s([0-9]{8}\s.*)/;		
		last;
	   }
	}
	close(INDEX);
	
	if(length($number) <= 0){
	   print "Sem resultados. \n";	   
	   return $data;
	}
       
		
	my @ids = split(" ",$number);
        my @sorted_ids = sort { $a <=> $b } @ids;
	foreach (@sorted_ids){ 
                 $id = $_;
                 open(DATA, $DIRETORIO.$DATA_NOUN) or die  "Couldn't open file "." ". $DATA_NOUN,", $!";		
                 while(<DATA>){		  
                     if(/^$id /){
                       $linha2 = $_;                                            
                       @palavras = split(/[0-9]/, extrairPalavras($linha2));
                       foreach(@palavras){
                          my $w = trim($_); 
                          # if($word ne $w){
                              $data{$w} = $w; 
                           # }
                       }                                            	
                       last;
                  }				 			
               }
               close(DATA);  
	}


        
         return $data;
      
}

sub percorrerArquivoData{
   
   
   open(DISCOVERDATA, $DIRETORIO_DISCOVER.$DISCOVER_DATA) or die  "Couldn't open file "." ". $DISCOVER_DATA,", $!";		
   while ( <DISCOVERDATA> ){
     chomp;
     push @discoverData, [ split /,/ ];
   }
   foreach $row (0..@discoverData-1){
      foreach $column (0..@{$discoverData[$row]}-1) {
         print "Element [$row][$column] = $discoverData[$row][$column] \n";
      }
   }
}


sub percorrerArquivoNomes{
   
   
   open(DISCOVERNAMES, $DIRETORIO_DISCOVER.$DISCOVER_NAMES) or die  "Couldn't open file "." ".$DISCOVER_NAMES,", $!";		
   while ( <DISCOVERNAMES> ){
     chomp;
     push @discoverNames, [ split /,/ ];
   }
   foreach $row (0..@discoverNames-1){
      foreach $column (0..@{$discoverNames[$row]}-1) {
         $palavra = extrairNomes($discoverNames[$row][$column]);
         print "Element [$row][$column] = $palavra \n";
      }
   }
}


sub buscaRecursiva{
   my $k = 0, $i = 0, $data = $_[0], %newHash, %retorno;
   $k += scalar keys %data;
   
   if($k == 0){
      return %data;
   }
   print " \n [LOG: Tamanho do data----> $k]\n\n";
   foreach $key (sort keys %data){
          
        if(length(trim($key)) > 2){
          print "  [LOG: PALAVRA USADA PARA BUSCA: ($key)] \n"; 
	  %retorno =  buscarSinonimos($key);
          %newHash = (%data, %retorno);       
	}                  

   }
     
   $i += scalar keys %newHash; 
   print " \n [LOG: Tamanho da NOVA lista de sinonimos: $i\n    Tamanho da ANTIGA lista de sinonimos: $k \n\n";
   if($i == $k ){
      return %data;
   }elsif($i == 0){
      return %data; #Exemplo shopping
   }
   return buscaRecursiva(%data); 
   
}
print "Digite a palavra: ";
chomp($palavra = <STDIN>);
my %hashList = buscaRecursiva(buscarSinonimos(lc $palavra));
#Listando sinônimos

print " \n - SINONIMOS ENCONTRADOS: \n";
foreach $key2 (sort keys %hashList){
   print "($key2) \n";
  
} 



# print "\n DATA : ";

# percorrerArquivoData();

# print "\n NAMES : ";

# percorrerArquivoNomes();