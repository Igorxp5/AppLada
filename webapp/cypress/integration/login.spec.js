/// <reference types="cypress" />

const base_url = 'http://localhost:3000';


describe('AppladaLogin', ()=>{

    beforeEach(()=>{
        cy.visit(base_url);
    })

    it('has title', ()=>{
        cy.contains('Entrar');
    })

    it('lets user log in successfuly using nickname', ()=>{
        cy.get('.entrance-content').get('form').get('input[name=login]').type('kayques');
        cy.get('.entrance-content').get('form').get('input[name=password]').type('12345678');
        cy.get('.entrance-button').contains('Entrar').click();
        cy.url().should('include', 'dashboard');
    })

    it('lets user log in successfuly using e-mail', ()=>{
        cy.get('.entrance-content').get('form').get('input[name=login]').type('skayque.lss@gmail.com');
        cy.get('.entrance-content').get('form').get('input[name=password]').type('12345678');
        cy.get('.entrance-button').contains('Entrar').click();
        cy.url().should('include', 'dashboard');
    })

    it('does not let user log in with invalid user nickname', ()=>{
        cy.get('.entrance-content').get('form').get('input[name=login]').type('kaayques');
        cy.get('.entrance-content').get('form').get('input[name=password]').type('12345678');
        cy.get('.entrance-button').contains('Entrar').click();
        cy.get('.app').contains('Usuário ou senha incorreta');
    })

    it('does not let user log in with invalid user password', ()=>{
        cy.get('.entrance-content').get('form').get('input[name=login]').type('kayques');
        cy.get('.entrance-content').get('form').get('input[name=password]').type('eqgwah');
        cy.get('.entrance-button').contains('Entrar').click();
        cy.get('.app').contains('Usuário ou senha incorreta');
    })

    it('does not let user log in with empty username field', ()=>{
        cy.get('.entrance-content').get('form').get('input[name=password]').type('12345678');
        cy.get('.entrance-button').contains('Entrar').click();
        cy.get('.app').contains('Please fill out this field.');
    })

    it('does not let user log in with empty password field', ()=>{
        cy.get('.entrance-content').get('form').get('input[name=login]').type('kayques');
        cy.get('.entrance-button').contains('Entrar').click();
        cy.get('.app').contains('Please fill out this field.');
    })

    it('does not let user log in with empty username and password fields', ()=>{
        cy.get('.entrance-button').contains('Entrar').click();
        cy.get('.app').contains('Please fill out this field.');
    })

})