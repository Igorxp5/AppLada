import React from 'react'
import './../style/search-input.css'

class SearchInput extends React.Component {

    render() {
        return(
            <input class="search-input" placeholder="PESQUISAR POR JOGADOR" style={this.props.style} onChange={this.props.onChange}/>
        )
    }
}

export default SearchInput