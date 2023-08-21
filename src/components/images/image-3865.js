import Img from "gatsby-image"
import * as React from "react"
import { useStaticQuery, graphql } from "gatsby"
// other imports

const SomeImage = () => {
  const data = useStaticQuery(graphql`
    query {
      featureimg: file(relativePath: { eq: "3865.jpg" }) {
        childImageSharp {
          fluid(maxWidth: 3865) {
            ...GatsbyImageSharpFluid
          }
        }
      }
    }
  `)

  return (
    <div className="first-post-thumbnail">
      <a href="/best-keyboard-for-wow/">
        <Img fluid={data.featureimg.childImageSharp.fluid} />
      </a>
    </div>
  )
}

export default SomeImage

