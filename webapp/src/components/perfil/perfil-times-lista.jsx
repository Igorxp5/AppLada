import React from 'react'

function TimesLista(props) {    
    const containerStyle = {
        width: '90%',
        paddingBottom: '15px',
        display: 'flex',
        justifyContent: 'center',
        flexDirection: 'column',
        color: 'white',
        borderBottom: '0.5px solid white'
    }    

    const dados = {
        width: '100%',
        fontSize: '1.3em'
    }
    return(
            <div style={containerStyle}>
                <div style={{width: '100%'}}>
                    <div style={{width: '100%', fontSize: '2em'}}>{props.nome}</div>
                    <div style={dados}>
                        <div style={{float:'left'}}><i class="fas fa-medal"></i>{props.vitorias} vitórias</div>
                        <div style={{float:'left', marginLeft: '10px'}}><i class="fas fa-user-friends"></i>{props.membros} membros</div>
                    </div>
                </div>
            </div>
        )
}

export default TimesLista