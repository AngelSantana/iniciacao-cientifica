#!/usr/bin/perl

$INDEX_NOUN = "index.noun";
$DATA_NOUN = "data.noun";
#$DIRETORIO = "D:/Projetos/WordNet/WordNet/dict/";
$DIRETORIO = "C:/WordNet/dict/";

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

         return $data;
      
}


print "Digite a palavra: ";
chomp($palavra = <STDIN>);
$data = buscarSinonimos(lc $palavra);
#Listando sinônimos
foreach $key (sort keys %data){
   print "($key) \n";
} 