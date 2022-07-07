import React, { Component } from 'react';
import { BarLoader } from 'react-spinners';

const LoadSpinnerHOC = (propsToBePresent, WrappedComponent) => {
  return class LoadSpinner extends Component {
    areAllNeededPropsPresent(){
      return propsToBePresent.every(x=>{return this.props[x]})
    }

    render(){
      return (
        this.areAllNeededPropsPresent() ? <WrappedComponent {...this.props} />
                                        : <BarLoader color="#8AE0D8" />
      )
    }
  }
}

export default LoadSpinnerHOC;
