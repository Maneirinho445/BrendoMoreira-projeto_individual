-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.

CREATE TABLE Usuario (
id_Usuario INTEGER PRIMARY KEY AUTO_INCREMENT,
Id_Permissao INTEGER,
Id_Cliente INTEGER,
Senha VARCHAR(15),
Email VARCHAR(30)
);

CREATE TABLE Permissão (
Id_Permissao INTEGER PRIMARY KEY,
Tipo VARCHAR(15)
);

CREATE TABLE Cliente (
Id_Cliente INTEGER PRIMARY KEY AUTO_INCREMENT,
Rua  VARCHAR(30),
Bairro VARCHAR(30),
Data_Cli VARCHAR(30),
Municipio VARCHAR(30),
Numero INTEGER,
Estado VARCHAR(30),
Telefone VARCHAR(20),
Cep VARCHAR(10),
Cpf VARCHAR(15),
Nome VARCHAR(50)
);

CREATE TABLE Reserva (
Id_Reserva INTEGER PRIMARY KEY AUTO_INCREMENT,
id_Usuario INTEGER,
Valor_total DOUBLE(10,2),
Pagamento VARCHAR(30),
FOREIGN KEY(id_Usuario) REFERENCES Usuario (id_Usuario)
);

CREATE TABLE Itens_Compra (
Id_itensCompra INTEGER PRIMARY KEY AUTO_INCREMENT,
Id_Itens_Pacote INTEGER,
Id_Reserva INTEGER,
Id_Voo INTEGER,
Valor_Itens DOUBLE(10,2),
Quantidade INTEGER,
FOREIGN KEY(Id_Reserva) REFERENCES Reserva (Id_Reserva)
);

CREATE TABLE Voo (
Id_Voo INTEGER PRIMARY KEY AUTO_INCREMENT,
Local_Partida VARCHAR(40),
Quantidade_Pessoas INTEGER,
Destino_voo VARCHAR(40),
Transfer VARCHAR(10),
Data_volta DATETIME,
Data_ida DATETIME,
Valor_viagem DOUBLE(10,2)

);

CREATE TABLE DiariasHotelaria (
Id_Hotel INTEGER PRIMARY KEY AUTO_INCREMENT,
Qtd_dias INTEGER,
Rua VARCHAR(40),
Numero INTEGER,
Cep VARCHAR(10),
Estado VARCHAR(40),
Municipio VARCHAR(40),
Nome_Hotel VARCHAR(40),
Qtd_Quartos INTEGER
);

CREATE TABLE Pacote (
Id_Itens_Pacote INTEGER PRIMARY KEY AUTO_INCREMENT,
Id_Hotel INTEGER,
Valor_Pacote DOUBLE(10,2),
Qtd_Pessoas_Pac INTEGER,
Tipo VARCHAR(15),
Pacote_ida DATETIME,
Pacote_volta DATETIME,
Destino VARCHAR(30),
Transfer_pacote VARCHAR(20),
FOREIGN KEY(Id_Hotel) REFERENCES DiariasHotelaria (Id_Hotel)
);

ALTER TABLE Usuario ADD FOREIGN KEY(Id_Permissao) REFERENCES Permissão (Id_Permissao);
ALTER TABLE Usuario ADD FOREIGN KEY(Id_Cliente) REFERENCES Cliente (Id_Cliente);
ALTER TABLE Itens_Compra ADD FOREIGN KEY(Id_Itens_Pacote) REFERENCES Pacote (Id_Itens_Pacote);
ALTER TABLE Itens_Compra ADD FOREIGN KEY(Id_Voo) REFERENCES Voo (Id_Voo);

create view Itens_geral1 as SELECT i.Id_itensCompra, i.Id_Itens_Pacote, i.Id_Reserva, i.id_Voo, i.Valor_Itens, i.Quantidade, p.Id_Hotel, p.Valor_Pacote, p.Qtd_Pessoas_Pac, p.tipo,p.Pacote_ida,p.Pacote_volta,p.Destino,p.transfer_pacote, r.id_Usuario, r.Valor_total, r.pagamento, v.quantidade_pessoas,v.destino_voo, v.Data_ida, v.Data_volta, v.transfer  FROM itens_compra i, pacote p, reserva r, 
voo v where i.Id_Itens_Pacote = p.Id_Itens_Pacote and i.Id_Reserva = r.Id_Reserva and i.Id_Voo = v.Id_Voo;

create view todos_reserva2 as select r.Id_Reserva, r.id_Usuario, r.Valor_total, r.Pagamento, u.senha, u.email, c.data_cli, c.nome, c.cpf, c.estado, 
c.telefone from reserva r, usuario u, cliente c where c.Id_Cliente = u.Id_Cliente and u.id_Usuario = r.id_Usuario;

create view Pacote_todos4 as select d.Nome_Hotel, d.Qtd_dias, d.Qtd_Quartos, d.Estado,d.Municipio, d.Rua, d.numero,p.Id_Itens_Pacote,p.Id_Hotel,p.Qtd_Pessoas_Pac, p.Tipo, p.Valor_Pacote,
 p.pacote_ida, p.pacote_volta, p.destino, p.transfer_pacote from diariashotelaria d, pacote p where p.Id_Hotel = d.Id_Hotel;

create view usuarios_completo as select u.id_Usuario, u.senha,u.Email, c.Id_Cliente, c.Nome , c.Cpf, c.Estado, c.Municipio, c.Telefone, p.Id_Permissao, p.Tipo  
from usuario u, cliente c, permissao p where u.id_permissao = p.Id_Permissao
and u.Id_cliente = c.Id_Cliente;
