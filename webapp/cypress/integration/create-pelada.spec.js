/// <reference types="cypress" />

const base_url = 'http://localhost:3000';


describe('AppladaCreatePelada', ()=>{

    beforeEach(()=>{
        cy.visit(base_url);
        cy.get('.entrance-content').get('form').get('input[name=login]').type('kayques');
        cy.get('.entrance-content').get('form').get('input[name=password]').type('12345678');
        cy.get('.entrance-button').contains('Entrar').click();
        cy.get('#jogar').click();
        cy.get('#minhas-peladas').click();
    })

    it('lets  user create a pelada successfully', ()=>{
        cy.get('#criar-peladas-container').get('form').get('input[name=titulo]').type("Pelada de Teste");
        cy.get('#criar-peladas-container').get('form').get('input[name=data]').type("01/01/2030");
        cy.get('#criar-peladas-container').get('form').get('input[name=de]').type("20:00");
        cy.get('#criar-peladas-container').get('form').get('input[name=ate]').type("21:00");
        cy.get('#criar-peladas-container').get('form').get('input[name=descricao]').type("Essa é uma pelada de teste.");
        cy.get('#criar-peladas-container').get('form').contains('Criar Conta').click();
        cy.get('.app').contains('Pelada criada com sucesso');
    })


    it('lets user see the created pelada on "Minhas Peladas"', ()=>{
        cy.get('#minhas-peladas').click();
        cy.should.contains('TÍTULO');
    })

    it('lets user see "Minhas Peladas"', ()=>{
        cy.get('#criar-pelada').click();
        cy.contains('Para criar uma pelada, preencha os campos abaixo, e marque no mapa ao lado o local de sua pelada.');
        cy.contains('TÍTULO');
        cy.contains('DATA');
        cy.contains('DE');
        cy.contains('ATÉ');
        cy.contains('DESCRIÇÃO');
        cy.contains('CRIAR PELADA');
    })

})