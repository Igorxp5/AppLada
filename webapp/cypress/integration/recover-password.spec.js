/// <reference types="cypress" />

const base_url = 'http://localhost:3000';


describe('AppladaRecoverPassword', ()=>{

    it('navigates to recover password page', ()=>{
        cy.visit(base_url);
        cy.get('.entrance-content').get('form').contains('Esqueci minha senha').click();
        cy.url().should('include', 'forgot-password');
    })

    it('has title', ()=>{
        cy.should('contain','Esqueci minha senha');
    })

    it('lets user recover its password using nickname', ()=>{
        cy.visit(base_url+'/forgot-password');
        cy.get('form').get('input[name=login]').type('kayques');
        cy.get('.entrance-button').contains('Enviar').click();
        cy.get('.app').should('contain','Link enviado para seu e-mail');
    })

    it('lets user recover its password using email', ()=>{
        cy.visit(base_url+'/forgot-password');
        cy.get('form').get('input[name=login]').type('skayque.lss@gmail.com');
        cy.get('.entrance-button').contains('Enviar').click();
        cy.get('.app').should('contain','Link enviado para seu e-mail');
    })


    it('does not let user recover password with empty fields', ()=>{
        cy.visit(base_url+'/forgot-password');
        cy.get('.entrance-button').contains('Enviar').click();
        cy.get('.app').should('contain','Please fill out this field.');
    })

    it('does not let user recover password with invalid username or email', ()=>{
        cy.visit(base_url+'/forgot-password');
        cy.get('form').get('input[name=login]').type('abcdefg');
        cy.get('.entrance-button').contains('Enviar').click();
        cy.get('.app').should('contain','Conta não existe');
    })

})