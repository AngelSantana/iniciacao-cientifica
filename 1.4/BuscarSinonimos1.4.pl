#!/usr/bin/perl
# Constantes
my $INDEX_NOUN = "index.noun";
my $DATA_NOUN = "data.noun";
#my $DIRETORIO = "D:/Projetos/WordNet/WordNet/dict/";
my $DIRETORIO = "C:/WordNet/dict/";
my $DISCOVER_DATA = "discover.data";
my $MEU_DISCOVER_DATA = "meuDiscover.data";
my $MEU_DISCOVER_NAMES = "meuDiscover.names";
my $DISCOVER_NAMES = "discover.names";
my $DIRETORIO_DISCOVER = "C:/WordNet/";
# perl trim function - remove leading and trailing whitespace
use strict;
use Informacao;
# Remover espaços antes e depois de uma string
sub trim($)
{
  my $string = shift;
  $string =~ s/^\s+//;
  $string =~ s/\s+$//;
  return $string;
}

sub extrairPalavras($){
   my $linha  = shift;
   my $nome;
   ($nome) = $linha =~ /(([a-z]){1}\S.*\b\s(@))/ ;
   ($linha) = $nome =~ /(([a-z]){1}\S.*.([a-z]){1}\b)/; 
                      
    return $linha;                   
}

sub extrairNomes{
   my $new = $_[0];
   my $palavra;
   ($palavra) = $new =~ /^(\"[a-zA-z]+\")/;
   ($new) = $palavra =~ /([a-zA-z]+)/;
   
   return ($new);
   
}

sub extrairDigitoByColchetes{
   my $new = $_[0];
   my $digito;
   ($digito) = $new =~ /(\b\d*[\d])/;
   
   
   return ($digito);
   
}

# Função para obter um hash de sinônimos.
# - parâmetro: palavra para busca.
sub buscarSinonimos($){
	my $word = trim($_[0]);
	my $number;	
	my $linha;
	my $number;
	my $nome;
	my $id; 
	my $linha2;
	my %data;
	my @palavras;
	 
	 #Ler o arquivo index.noun
	open(INDEX, $DIRETORIO.$INDEX_NOUN) or die  "Couldn't open file "." ". $INDEX_NOUN,", $!";		
	
	while(<INDEX>){		  
	   if(/^$word /){# Pesquisa a palavra informada.
		$linha = $_;				
		($number) = $linha =~ /\s([0-9]{8}\s.*)/;	#Obtém os ids da linha referente aos sinônimos.	
		last;
	   }
	}
	close(INDEX);
	 
	 #Se não encontrou nenhum número, quer dizer que não encontrou palavra.
	 #Retorna o hash %data vazio.
	if(length($number) <= 0){
	   print "Sem resultados. \n";	   
	   return %data;
	}
	       
	
	my @ids = split(" ",$number); #Pega os ids na linha do arquivo.	
        my @sorted_ids = sort { $a <=> $b } @ids; #Ordena os ids.
	foreach (@sorted_ids){ 
                 $id = $_;
                 open(DATA, $DIRETORIO.$DATA_NOUN) or die  "Couldn't open file "." ". $DATA_NOUN,", $!"; #Ler o arquivo data.noun		
                 while(<DATA>){		  
                     if(/^$id /){#Pega o ID da lista ordenada e pesquisa as palavras que são relacionadas ao mesmo.
                       $linha2 = $_;                                            
                       @palavras = split(/[0-9]/, extrairPalavras($linha2)); # Obtém as palavras da linha do arquivo
                       foreach(@palavras){ # Adiciona as palavras encontradas ao hash $data
                          my $w = trim($_);                           
                          # if($word ne $w){
                              $data{$w} = $w;    # Exemplo: key = student, value = student.                          
                           # }
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
   
   my @discoverData;
   my $row;
   my $column;
   
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
  my $k = 0;
  my $i = 0;
  my %newHash;
  my %retorno;
  my %data;
  my $key;
  %data = @_;
 
   $k += scalar keys %data;

   if($k == 0 or $k >= 10){
      return %data;
   }
   print " \n [LOG: Tamanho do data----> $k]\n\n";
   foreach $key (sort keys %data){
          
        if(length(trim($key)) > 2){
          print "  [LOG: PALAVRA USADA PARA BUSCA: ($key)] \n"; 
	  %retorno =  buscarSinonimos($key);
	  
	  # foreach $key (sort keys %retorno){
          
                   # print "      \n  [LOG: RETORNO HASH: ($key)] \n";                      
                                   
           # }
	  
          #%newHash = (%data, %retorno);     
          @data{keys %retorno} = values %retorno;
                
       
      }
     # foreach $key (sort keys %data){
          
                   # print "                           \n  [LOG:DATA --- NOVO HASH: ($key)] \n";                      
                                       
           # }     
   }           
   $i += scalar keys %data; 
   print " \n [LOG: Tamanho da NOVA lista de sinonimos: $i\n    Tamanho da ANTIGA lista de sinonimos: $k \n\n";
   if($i == $k or $i == 0 ){
      return %data; #Exemplo shopping
   }
   return buscaRecursiva(%data); 
}

sub mapearArquivoNomes{

       my @discoverNames;
       my $row;
       my $column;
       my %hashMapeamentoArqData;
      open(DISCOVERNAMES, $DIRETORIO_DISCOVER.$DISCOVER_NAMES) or die  "Couldn't open file "." ".$DISCOVER_NAMES,", $!";		
      while ( <DISCOVERNAMES> ){
        chomp;
        push @discoverNames, [ split /,/ ];
      }
      
      
      foreach $row (0..@discoverNames-1){              
         foreach $column (0..@{$discoverNames[$row]}-1) {
            my $palavra = extrairNomes($discoverNames[$row][$column]);
            if(length($palavra) > 0){
               
               #----------------------------------------
               my $informacao = Informacao->new( string => $palavra, integer => $row);
               print "Teste Nome  : " . $informacao->getTermo . "\n"; 
               print "Teste Posicao : " . $informacao->getPosicao . "\n";
               $hashMapeamentoArqData{$informacao->getTermo} = $informacao; 
               #$exemplo->set_exemplo3( set => "inserindo no string exemplo 3");
               #print "Teste exemplo 3 : " . $exemplo->get_exemplo3 . "\n";
               #-------------------------------------------------------------   
            }            
      }   
   }
   
   return %hashMapeamentoArqData;
}

sub mapearArquivoData{
   my %parametroHashArqNames = @_;
   
   my @discoverData;
   
   
   my $nomeDocumento;
   my $otherValue;
   my $newValue;
   my %newValue;
   my %hashOfHash; # Hash data contém Hash dos nomes correspondente a cada linha
   my $parametroHashArqNames;
   open(DISCOVERDATA, $DIRETORIO_DISCOVER.$DISCOVER_DATA) or die  "Couldn't open file "." ". $DISCOVER_DATA,", $!";		
   while ( <DISCOVERDATA> ){
     chomp;
     push @discoverData, [ split /,/ ];
   }
   
   foreach my $row (0..@discoverData-1){    
      $nomeDocumento = $discoverData[$row][0];
      print "$nomeDocumento \n";
      foreach my $column(0..@{$discoverData[$row]}-1) {
         #print "Element [$row][$column] = $discoverData[$row][$column] \n";   
         
         foreach my $value (sort values %parametroHashArqNames){
               
            if($value->getPosicao eq $column){
               # print "Oi $column \n";     
               # $value->setValor(set => $discoverData[$row][$column]);
               # $value->setNomeDocumento(set => $nomeDocumento);
               
                my $informacao = Informacao->new( string => $value->getTermo, integer => $value->getPosicao);
                $informacao->setValor(set => $discoverData[$row][$column]);
                $informacao->setNomeDocumento(set => $nomeDocumento);                
                $informacao->setIndexSinonimos(set => $value->getIndexSinonimos);
                $informacao->setPosicaoDocumento(set => $row);
   
                $hashOfHash{$nomeDocumento}{$value->getTermo}{$value->getPosicao}   =  $informacao;
            }
            
         }       
      }
   }
   
   foreach my $docNome (sort keys  %hashOfHash) {#Nome do documento
       foreach my $termo (sort keys %{ $hashOfHash{$docNome} }) {# Termo
          foreach my $posicao (sort keys %{ $hashOfHash{$docNome}{$termo} }) {# Termo
              print "Nome documento : " . $hashOfHash{$docNome}{$termo}{$posicao}->getNomeDocumento . "\n";
              print "Termo  : " . $hashOfHash{$docNome}{$termo}{$posicao}->getTermo . "\n"; 
              print "Posicao do termo : " . $hashOfHash{$docNome}{$termo}{$posicao}->getPosicao . "\n";
              print "Valor do termo no documento informado : " . $hashOfHash{$docNome}{$termo}{$posicao}->getValor . "\n";
              print "Valor do termo no documento informado : " . $hashOfHash{$docNome}{$termo}{$posicao}->getValor . "\n";
               #Listando sinônimos
               print "Index e nome sinonimos localizados: ".  $hashOfHash{$docNome}{$termo}{$posicao}->getIndexSinonimos ."\n\n\n";
               
              
              # foreach my $b (sort keys  $hashOfHash{$docNome}{$termo}{$posicao}->getIndexSinonimos){
               # print "----- TesteSinonimos : " . $b . "\n";
            # }
           }    
       }
   }
   
   return %hashOfHash;
   

}

sub alterarArquivoData{
   
   my @discoverData;
   my $row;
   my $column;
   my %hashRef = mapearArquivoData(percorrerArquivoNomes());
   
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
   my @colunasSeremRemovidas;

  foreach my $docNome (sort keys  %hashRef) {#Nome do documento
       foreach my $termo (sort keys %{ $hashRef{$docNome} }) {# Termo
          foreach my $posicao (sort keys %{ $hashRef{$docNome}{$termo} }) {# Termo
              my $posicaoTermoColuna = $hashRef{$docNome}{$termo}{$posicao}->getPosicao;
              my $string = $hashRef{$docNome}{$termo}{$posicao}->getIndexSinonimos;
              my $posicaoLinhaDocumento = $hashRef{$docNome}{$termo}{$posicao}->getPosicaoDocumento;
              my $valorTermo = $hashRef{$docNome}{$termo}{$posicao}->getValor;
              
              print "Nome documento : " . $hashRef{$docNome}{$termo}{$posicao}->getNomeDocumento . "\n";
              print "Termo  : " . $hashRef{$docNome}{$termo}{$posicao}->getTermo . "\n"; 
              print "Posicao do termo : " . $posicaoTermoColuna . "\n";
              print "Linha documento: ".$posicaoLinhaDocumento."\n";
              print "Valor do termo no documento informado : " .$hashRef{$docNome}{$termo}{$posicao}->getValor . "\n";
              
              print "Index e nome sinonimos localizados: ".  $string ."\n\n\n";
              
              
               #### Rever melhoria
               if(length($string) > 0){
                  print "Index e nome sinonimos localizados: ".  $string ."\n\n\n";
                  my @array = split(";", $string);
                  # my @sorted_ids = sort { $a <=> $b } @array; #Ordena os ids.
                  foreach (@array){ 
                     my $digito = extrairDigitoByColchetes($_);
                     push(@colunasSeremRemovidas, $digito);
                     print "--------Digito-----> $digito \n";
                     $discoverData[$posicaoLinhaDocumento][$posicaoTermoColuna] =  $discoverData[$posicaoLinhaDocumento][$posicaoTermoColuna] + $discoverData[$posicaoLinhaDocumento][$digito]  ;
                     $discoverData[$posicaoLinhaDocumento][$digito] = 0;
                  }
              }
              # foreach my $b (sort keys  $hashOfHash{$docNome}{$termo}{$posicao}->getIndexSinonimos){
               # print "----- TesteSinonimos : " . $b . "\n";
            # }
           }    
       }
   }
   
   # Exemplo :
   # $discoverData[0][6] = 30;
   # $linha = join(',', @{$discoverData[$row]}); 
   # print "$linha \n"
   foreach $row (0..@discoverData-1){  
      foreach(@colunasSeremRemovidas){
         $discoverData[$row][$_] = "";
      }
   }
   open my $meuArquivo, ">", $MEU_DISCOVER_DATA or die "Can't create ".$MEU_DISCOVER_DATA."'\n";    
   foreach $row (0..@discoverData-1){    
      #foreach $column (0..@{$discoverData[$row]}-1) {
            my $linha = join(',', @{$discoverData[$row]});
            $linha =~ s/,,/,/g; 
            print  $meuArquivo "$linha \n"
     # }
   }
   close $meuArquivo;
}


sub percorrerArquivoNomes{
      
       my @discoverNames;
       my $row;
       my $column;
       my $otherRow;
       my $otherColumn;
       my $palavraArquivo;
       my $encontrei = 0;
       my %novoHashMapeado = mapearArquivoNomes();        
       my $novoHashMapeado;
       my $string;
      open(DISCOVERNAMES, $DIRETORIO_DISCOVER.$DISCOVER_NAMES) or die  "Couldn't open file "." ".$DISCOVER_NAMES,", $!";		
      while ( <DISCOVERNAMES> ){
        chomp;
        push @discoverNames, [ split /,/ ];
      }
      
      open my $meuArquivo, ">", $MEU_DISCOVER_NAMES or die "Can't create ".$MEU_DISCOVER_NAMES."'\n";    
       foreach $row (0..@discoverNames-1){              
          foreach $column (0..@{$discoverNames[$row]}-1) {
            # print "Element [$row][$column] = $palavra \n";
      
            my $palavra = extrairNomes($discoverNames[$row][$column]);          
            my $key;           
            ##################################################
            if(length($palavra) > 0){
               my $i = 0;              
               my %hashList = buscaRecursiva(buscarSinonimos($palavra));   
            
               #Listando sinônimos
               $i += scalar keys %hashList;
               print $meuArquivo "$palavra: ";
               if($i > 0 ){
                  foreach $key (sort keys %hashList){                                      
                     # Utilizando minha lista de sinônimos, verifico se ele esta no arquivo, caso esteja, eu removo a linha do mesmo no arquivo
                     # e marco a key que usei p/ busca no meuDiscover.names. Por exemplo [student] encontrei no arquivo. 
                     ################################################################# INÍCIO V0.2
                      foreach $otherRow (0..@discoverNames-1){              
                        foreach $otherColumn (0..@{$discoverNames[$otherRow]}-1) {                          
                           $palavraArquivo = extrairNomes($discoverNames[$otherRow][$otherColumn]);                                                     
                           if(($key eq $palavraArquivo) and ($palavra ne $key)){
                              $encontrei = 1;
                               my $SEPARADORDADOS = "|";
                               my $CINICIO = "[";
                               my $CFIM = "]";
                               my $SEPARADORINFOR = ";";
                               $string = $string.$CINICIO.$otherRow.$CFIM.$SEPARADORDADOS.$key.$SEPARADORINFOR; 
                               $discoverNames[$otherRow][$otherColumn] = "";
                           }
                        }                                               
                     }
                    
                                        
                    if($encontrei){                      
                        print $meuArquivo "[$key] | ";           
                     }else{
                         print $meuArquivo "$key | ";  
                     }
                     $encontrei = 0;
                     
                     ############################################################## FIM V0.2
                  }                   
               }
               $novoHashMapeado{$palavra}->setIndexSinonimos(set => $string);
               $string = "";
               print $meuArquivo "\n";
               ################################################## 
               # $i += scalar keys %hashList; 
               # if($i > 0){
               #    print $meuArquivo "\n";
               # }
               #map { delete $hashList{$_} } keys %hashList;
              
             
             }
          }
      
      }
   close $meuArquivo;  
   
   return %novoHashMapeado;             
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

#########################################################

#print "\n DATA : \n";

#percorrerArquivoData();

#print "\n NAMES : \n";

#percorrerArquivoNomes();

#mapearArquivoData(mapearArquivoNomes());
#mapearArquivoData(percorrerArquivoNomes());

alterarArquivoData();