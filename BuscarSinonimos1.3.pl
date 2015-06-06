#!/usr/bin/perl

$INDEX_NOUN = "index.noun";
$DATA_NOUN = "data.noun";
#$DIRETORIO = "D:/Projetos/WordNet/WordNet/dict/";
$DIRETORIO = "C:/WordNet/dict/";
$DISCOVER_DATA = "discover.data";
$MEU_DISCOVER_DATA = "meuDiscover.data";
$MEU_DISCOVER_NAMES = "meuDiscover.names";
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
   $new = $_[0];
   ($palavra) = $new =~ /^(\"[a-zA-z]+\")/;
   ($new) = $palavra =~ /([a-zA-z]+)/;
   
   return ($new);
   
}

sub buscarSinonimos{
	$word = $_[0];
	my $number;	 
	open(INDEX, $DIRETORIO.$INDEX_NOUN) or die  "Couldn't open file "." ". $INDEX_NOUN,", $!";		
	
	while(<INDEX>){		  
	   if(/\b$word\b/){
		$linha = $_;				
		($number) = $linha =~ /\s([0-9]{8}\s.*)/;		
		last;
	   }
	}
	close(INDEX);
	
	if(length($number) <= 0){
	   print "Sem resultados. \n";
	   return;
	}

	my $nome;	
	@ids = split(" ",$number);
        my @sorted_ids = sort { $a <=> $b } @ids;
	foreach (@sorted_ids){ 
                 $id = $_;
                 open(DATA, $DIRETORIO.$DATA_NOUN) or die  "Couldn't open file "." ". $DATA_NOUN,", $!";		
                 while(<DATA>){		  
                     if(/^$id/){
                       $linha2 = $_;                                            
                       @palavras = split(/[0-9]/, extrairPalavras($linha2));
                       foreach(@palavras){
                          $w = $_; 
                          $data{trim($w)} = trim($w); 
                       }                                            	
                       last;
                  }				 			
               }
               close(DATA);  
	}


        
         return %data;
      
}

sub meuArquivoData{
   # my $existingdir = './mydirectory';
   # mkdir $existingdir unless -d $existingdir; # Check if dir exists. If not create it.
   # open my $fileHandle, ">>", "$existingdir/filetocreate.txt" or die "Can't open '$existingdir/filetocreate.txt'\n";
   # print $fileHandle "FooBar!\n";
   # close $fileHandle;  
   
   
   open my $meuArquivo, ">>", $MEU_DISCOVER_DATA or die "Can't create ".$MEU_DISCOVER_DATA."'\n";
   print $meuArquivo "FooBar! ";
   print $meuArquivo "FooBar! ";
   print $meuArquivo "FooBar! ";
   close $meuArquivo; 
   
   # open my $fileHandle, ">>", "meuDiscover.data" or die "Can't create meuDiscover.data '\n";
   # print $fileHandle "FooBar3!\n";
   # close $fileHandle; 
   
   
}

sub meuArquivoNames{
   # my $existingdir = './mydirectory';
   # mkdir $existingdir unless -d $existingdir; # Check if dir exists. If not create it.
   # open my $fileHandle, ">>", "$existingdir/filetocreate.txt" or die "Can't open '$existingdir/filetocreate.txt'\n";
   # print $fileHandle "FooBar!\n";
   # close $fileHandle;  
   
   
   open my $meuArquivo, ">>", $MEU_DISCOVER_NAMES or die "Can't create ".$MEU_DISCOVER_NAMES."'\n";
   print $meuArquivo "FooBar!\n";
   close $meuArquivo; 
   
   # open my $fileHandle, ">>", "meuDiscover.data" or die "Can't create meuDiscover.data '\n";
   # print $fileHandle "FooBar3!\n";
   # close $fileHandle; 
   
   
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
   
   # Exemplo :
   # $discoverData[0][6] = 30;
   # $linha = join(',', @{$discoverData[$row]}); 
   # print "$linha \n"
}





sub buscaRecursiva{
   my $k = 0, $i = 0;
   $k += scalar keys %data;
   
   if($k == 0){
      return;
   }
   
   foreach $key (sort keys %data){
      print " PALAVRA USADA PARA BUSCA: ($key) \n"; 
      if($word ne $key) {          
          %retorno =  buscarSinonimos($key);
          %newHash = (%data, %retorno);          
           
      }    
   }
     
   $i += scalar keys %newHash; 
   print "$i --- $k";
   if(($k eq $i) or $i == 0 or $i > 12){      
      map { delete $data{$_} } keys %data;
      return;
   }
  
   return buscaRecursiva(%newHash); 
   
}


sub percorrerArquivoNomes{
   
   
      open(DISCOVERNAMES, $DIRETORIO_DISCOVER.$DISCOVER_NAMES) or die  "Couldn't open file "." ".$DISCOVER_NAMES,", $!";		
      while ( <DISCOVERNAMES> ){
        chomp;
        push @discoverNames, [ split /,/ ];
      }
      
     
      foreach $row (0..@discoverNames-1){      
         open my $meuArquivo, ">>", $MEU_DISCOVER_NAMES or die "Can't create ".$MEU_DISCOVER_NAMES."'\n";    
         foreach $column (0..@{$discoverNames[$row]}-1) {
            # print "Element [$row][$column] = $palavra \n";
            $palavra = extrairNomes($discoverNames[$row][$column]);
            ##################################################
            if(length($palavra) > 0){
               my $i = 0;
               buscaRecursiva(buscarSinonimos($palavra));           
               #Listando sinônimos
               foreach $key2 (sort keys %newHash){
                  # print "----------> $key2";
                  print $meuArquivo "$key2,";           
               } 
               ################################################## 
               $i += scalar keys %newHash; 
               if($i > 0){
                  print $meuArquivo "\n";
               }
               map { delete $newHash{$_} } keys %newHash;
               close $meuArquivo;  
            }
         }             
      }
   
}

# print "Digite a palavra: ";
# chomp($palavra = <STDIN>);
# buscaRecursiva(buscarSinonimos(lc $palavra));
# #Listando sinônimos

# print "\n SINONIMOS ENCONTRADOS: \n";
# foreach $key2 (sort keys %newHash){
   # print "($key2) \n";
  
# } 

# meuArquivoData();
print "\n DATA : \n";

percorrerArquivoData();

print "\n NAMES : \n";

percorrerArquivoNomes();