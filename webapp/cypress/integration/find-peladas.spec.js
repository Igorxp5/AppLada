/// <reference types="cypress" />

const base_url = 'http://localhost:3000';


describe('AppladaFindPeladas', ()=>{

    beforeEach(()=>{
        cy.visit(base_url);
        cy.get('.entrance-content').get('form').get('input[name=login]').type('kayques');
        cy.get('.entrance-content').get('form').get('input[name=password]').type('12345678');
        cy.get('.entrance-button').contains('Entrar').click();
        cy.get('#jogar').click();
    })

    it('has main menu', ()=>{
        cy.url().should('include', 'dashboard');
        cy.contains('JOGAR');
        cy.contains('PERFIL');
        cy.contains('FEED');
        cy.contains('TIMES');
        cy.contains('TORNEIOS');
    })

    it('has submenu', ()=>{
        cy.contains('PELADAS PROXIMAS');
        cy.contains('MINHAS PELADAS');
        cy.contains('CRIAR PELADA');
    })

    it('lets user see "Peladas Próximas"', ()=>{
        cy.get('#peladas-proximas').click();
        cy.contains('TÍTULO');
        cy.contains('DATA/HORA');
        cy.contains('DISTÂNCIA');
        cy.contains('CRIADA POR');
    })


    it('lets user see "Minhas Peladas"', ()=>{
        cy.get('#minhas-peladas').click();
        cy.contains('TÍTULO');
        cy.contains('DATA/HORA');
        cy.contains('DISTÂNCIA');
        cy.contains('CRIADA POR');
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