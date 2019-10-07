import React from 'react'
import './../../style/entrance.css';

function EntranceButton(props) {
    let { ...others } = props;
    let icon = (props.icon !== undefined) ? ' ' + props.icon : ''
    let color = (props.color !== undefined) ? ' ' + props.color : ''
    return(
        <button className={'entrance-button' + icon + color} { ...others }>
            {props.text}
        </button>
    )
}

export default EntranceButton;