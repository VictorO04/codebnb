
import bcrypt from 'bcryptjs';

try {
    process.loadEnvFile();
} catch {
    console.error('❌ Arquivo .env não encontrado');
    process.exit(1);
}

const { criptografar } = await import('../src/lib/cripto.js');
const { prisma } = await import('../src/lib/prisma.js');

// Seed completo com 4 registros para cada tabela
const dados = {
    usuario: [
        { nome: 'admin', senha: bcrypt.hashSync('admin123', 10) },
        { nome: 'joao_silva', senha: bcrypt.hashSync('senha123', 10) },
        { nome: 'maria_souza', senha: bcrypt.hashSync('senha123', 10) },
        { nome: 'pedro_santos', senha: bcrypt.hashSync('senha123', 10) }
    ],

    cliente: [
        { nome: 'Ana Oliveira', cpf: criptografar('111.111.111-11'), celular: '(11) 91111-1111' },
        { nome: 'Bruno Costa', cpf: criptografar('222.222.222-22'), celular: '(11) 92222-2222' },
        { nome: 'Carlos Mendes', cpf: criptografar('333.333.333-33'), celular: '(11) 93333-3333' },
        { nome: 'Diana Rocha', cpf: criptografar('444.444.444-44'), celular: '(11) 94444-4444' }
    ],

    imoveis: [
        { endereco: 'Rua das Flores, 123 - Centro', cliente_id: 1 },
        { endereco: 'Avenida Brasil, 1500 - Bela Vista', cliente_id: 2 },
        { endereco: 'Praça da Sé, 45 - Sé', cliente_id: 3 },
        { endereco: 'Alameda Santos, 987 - Cerqueira César', cliente_id: 4 }
    ],

    alugueis: [
        { data: new Date('2026-01-15T10:00:00Z'), imoveis_id: 1 },
        { data: new Date('2026-02-20T14:30:00Z'), imoveis_id: 2 },
        { data: new Date('2026-05-10T09:15:00Z'), imoveis_id: 3 },
        { data: new Date('2026-11-05T16:45:00Z'), imoveis_id: 4 }
    ]
};

async function executarSeed() {
    try {
        console.log('🚀 Iniciando seed...');

        await prisma.$transaction(async (tx) => {
            // Limpa as tabelas respeitando as chaves estrangeiras
            await tx.alugueis.deleteMany();
            await tx.imoveis.deleteMany();
            await tx.cliente.deleteMany();
            await tx.usuario.deleteMany();

            // Insere os registros na ordem correta
            for (const [tabela, registros] of Object.entries(dados)) {
                const resultado = await tx[tabela].createMany({
                    data: registros
                });

                console.log(
                    `✅ ${tabela}: ${resultado.count} registros inseridos`
                );
            }
        });

        console.log('🎉 Seed executado com sucesso!');

    } catch (error) {
        console.error('❌ Erro ao executar seed:', error);
        process.exitCode = 1;

    } finally {
        await prisma.$disconnect();
    }
}

executarSeed();
