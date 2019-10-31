import React from 'react'

function PeladaInfo(props) {

    let styleList = {
        listStyle: 'none',
        display: 'flex',
        padding: '15px',
        width: '100%',
        justifyContent: 'space-evenly'
    }

    return (
        <div>
            <ul style={styleList}>
                <li>{props.titulo}</li>
                <li>{props.dataHora}</li>
                <li>{props.distancia}</li>
                <li>{props.criador}</li>
            </ul>
        </div>
    )
}

export default PeladaInfo;