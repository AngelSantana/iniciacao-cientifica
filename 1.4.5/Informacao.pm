package Informacao;

use strict;
use warnings;

sub new {
    my $proto = shift;
    my $class = ref($proto) || $proto;
    my %args = @_;

    my $termo=$args{string};
    my $posicao=$args{integer};

    my $self={ 
        termo => $termo,
        posicao => $posicao,
        valor => undef,
        nomeDocumento => undef,
        indexSinonimos => undef,
        posicaoDocumento => undef,
    };

    bless($self,$class);
    return $self;
}

sub getTermo {
    my $self=shift;
    return $self->{termo};
}

sub getPosicao {
    my $self=shift;
    return $self->{posicao};
}

sub setValor {
    my $self=shift;
    my %args=@_;
    
    my $set=$args{set};
    $self->{valor}=$set;
}

sub getValor {
    my $self=shift;
    return $self-> {valor};
}

sub setNomeDocumento {
    my $self=shift;
    my %args=@_;
    
    my $set=$args{set};
    $self->{nomeDocumento}=$set;
}

sub getNomeDocumento {
    my $self=shift;
    return $self-> {nomeDocumento};
}
# sub setIndexSinonimos {
    # my ( $self, $indexSinonimos ) = @_;
    # $self->{_indexSinonimos} = $indexSinonimos if defined($indexSinonimos);
    # return $self->{_indexSinonimos};
# }

sub setIndexSinonimos {
    my $self=shift;
    my %args = @_;
    
    my $set=$args{set};
    $self->{indexSinonimos}=$set;
}

sub getIndexSinonimos {
    my $self=shift;
    return $self->{indexSinonimos};
}

# sub getIndexSinonimos {
    # my ($self) = @_;
    # return $self->{_indexSinonimos};
# }

sub setPosicaoDocumento {
    my $self=shift;
    my %args = @_;
    
    my $set=$args{set};
    $self->{posicaoDocumento}=$set;
}

sub getPosicaoDocumento {
    my $self=shift;
    return $self->{posicaoDocumento};
}

1; 