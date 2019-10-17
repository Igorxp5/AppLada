/// <reference types="cypress" />

import Chance from 'chance';
const chance = new Chance();

const base_url = 'http://localhost:3000';

describe('AppladaSignup', ()=>{


    it('navigates to signup page', ()=>{
        cy.visit(base_url);
        cy.get('.entrance-content').get('form').contains('Criar uma conta').click();
        cy.url().should('include', 'signup');
    })

    it('has title', ()=>{
        cy.visit(base_url+'/signup');
        cy.contains('Registrar-se');
    })

    const test_name = 'Applada Test User';
    const test_username = 'applada_test_user'+(Math.floor(Math.random() * 100) + 1);
    const test_email = chance.email();
    const test_birthday = '2000-05-08'
    const test_pass =  'appladatest';

    it('lets user sign up successfully', ()=> {
        cy.get('.entrance-content').get('form').get('input[name=name]').type(test_name);
        cy.get('.entrance-content').get('form').get('input[name=login]').type(test_username);
        cy.get('.entrance-content').get('form').get('input[name=email]').type(test_email);
        cy.get('.entrance-content').get('form').get('input[name=birthday]').click().type(test_birthday);
        cy.get('.entrance-content').get('form').get('.entrance-input').get('select').select('Outros');
        cy.get('.entrance-content').get('form').get('input[name=password]').type(test_pass);
        cy.get('.entrance-content').get('form').get('input[name=confirmPassword]').type(test_pass);
        cy.get('.entrance-button').contains('Criar Conta').click();
        cy.get('.app').contains('Usuário criado com sucesso');
        cy.url().should('be', base_url);
    })

    it('lets user log in successfully with recently created account using nickname', ()=> {
        cy.visit(base_url);
        cy.get('.entrance-content').get('form').get('input[name=login]').type(test_username);
        cy.get('.entrance-content').get('form').get('input[name=password]').type(test_pass);
        cy.get('.entrance-button').contains('Entrar').click();
        cy.url().should('include', 'dashboard');
    })

    it('lets user log in successfully with recently created account using email', ()=> {
        cy.visit(base_url);
        cy.get('.entrance-content').get('form').get('input[name=login]').type(test_email);
        cy.get('.entrance-content').get('form').get('input[name=password]').type(test_pass);
        cy.get('.entrance-button').contains('Entrar').click();
        cy.url().should('include', 'dashboard');
    })

    it('does not let user create account with empty fields', ()=>{
        cy.visit(base_url+'/signup');
        cy.get('.entrance-button').contains('Criar Conta').click();
        cy.get('.app').contains('Please fill out this field.');
    })

    it('does not let user create account with email that does not contain @', ()=> {
        cy.visit(base_url+'/signup');
        cy.get('.entrance-content').get('form').get('input[name=name]').type(test_name);
        cy.get('.entrance-content').get('form').get('input[name=login]').type(test_username);
        cy.get('.entrance-content').get('form').get('input[name=email]').type('appladatest');
        cy.get('.entrance-content').get('form').get('input[name=birthday]').click().type(test_birthday);
        cy.get('.entrance-content').get('form').get('.entrance-input').get('select').select('Outros');
        cy.get('.entrance-content').get('form').get('input[name=password]').type(test_pass);
        cy.get('.entrance-content').get('form').get('input[name=confirmPassword]').type(test_pass);
        cy.get('.entrance-button').contains('Criar Conta').click();
        cy.get('.app').contains("Please include an '@' in the email address");
        cy.url().should('be', base_url);
    })

    it('does not let user create account with email that ends with "."', ()=> {
        cy.visit(base_url+'/signup');
        cy.get('.entrance-content').get('form').get('input[name=name]').type(test_name);
        cy.get('.entrance-content').get('form').get('input[name=login]').type(test_username);
        cy.get('.entrance-content').get('form').get('input[name=email]').type('appladatest@abc.');
        cy.get('.entrance-content').get('form').get('input[name=birthday]').click().type(test_birthday);
        cy.get('.entrance-content').get('form').get('.entrance-input').get('select').select('Outros');
        cy.get('.entrance-content').get('form').get('input[name=password]').type(test_pass);
        cy.get('.entrance-content').get('form').get('input[name=confirmPassword]').type(test_pass);
        cy.get('.entrance-button').contains('Criar Conta').click();
        cy.get('.app').contains("'.' is used at a wrong position in" );
        cy.url().should('be', base_url);
    })

    it('does not let user create account with unmatching passwords', ()=> {
        cy.visit(base_url+'/signup');
        cy.get('.entrance-content').get('form').get('input[name=name]').type(test_name);
        cy.get('.entrance-content').get('form').get('input[name=login]').type(test_username);
        cy.get('.entrance-content').get('form').get('input[name=email]').type(test_email);
        cy.get('.entrance-content').get('form').get('input[name=birthday]').click().type(test_birthday);
        cy.get('.entrance-content').get('form').get('.entrance-input').get('select').select('Outros');
        cy.get('.entrance-content').get('form').get('input[name=password]').type(test_pass);
        cy.get('.entrance-content').get('form').get('input[name=confirmPassword]').type(test_pass+'12345');
        cy.get('.entrance-button').contains('Criar Conta').click();
        cy.get('.app').contains("As senhas não coincidem" );
        cy.url().should('be', base_url);
    })

    it('does not let user create account with already used username or email', ()=> {
        cy.visit(base_url+'/signup');
        cy.get('.entrance-content').get('form').get('input[name=name]').type(test_name);
        cy.get('.entrance-content').get('form').get('input[name=login]').type(test_username);
        cy.get('.entrance-content').get('form').get('input[name=email]').type(test_email);
        cy.get('.entrance-content').get('form').get('input[name=birthday]').click().type(test_birthday);
        cy.get('.entrance-content').get('form').get('.entrance-input').get('select').select('Outros');
        cy.get('.entrance-content').get('form').get('input[name=password]').type(test_pass);
        cy.get('.entrance-content').get('form').get('input[name=confirmPassword]').type(test_pass);
        cy.get('.entrance-button').contains('Criar Conta').click();
        cy.get('.app').contains('O Usuário já foi utilizado');
        cy.get('.app').contains('O Email já foi utilizado');
    })

})