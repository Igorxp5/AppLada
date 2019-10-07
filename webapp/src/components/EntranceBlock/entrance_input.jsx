import React from 'react'
import './../../style/entrance.css';

function EntranceInput(props) {
    let { ...other } = props;
    return(
        <input { ...other } className='entrance-input'/>
    )
}

export default EntranceInput;