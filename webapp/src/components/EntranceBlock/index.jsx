import React from 'react'
import './../../style/entrance.css';
import EntranceButton from './entrance_button'
import EntranceInput from './entrance_input'


function EntranceBlock(props) {
    return(
        <div className='entrance-container'>
        	<h2 className='entrance-title'>{props.title}</h2>
        	<div className='entrance-alternatives'>
        		<EntranceButton text='Google' icon='google' color='white'/>
        	</div>
            <div className='entrance-alternatives-seperator'>OU</div>
        	<div className='entrance-content'>
        		{props.children}
        	</div>
        </div>
    )
}

export { EntranceBlock, EntranceButton, EntranceInput };