$file = @"
import Img from "gatsby-image"
import * as React from "react"
import { useStaticQuery, graphql } from "gatsby"
// other imports

const SomeImage = () => {
  const data = useStaticQuery(graphql``
    query {
      featureimg: file(relativePath: { eq: "__ID__.jpg" }) {
        childImageSharp {
          fluid(maxWidth: __ID__) {
            ...GatsbyImageSharpFluid
          }
        }
      }
    }
  ``)

  return (
    <div className="first-post-thumbnail">
      <a href="/best-keyboard-for-wow/">
        <Img fluid={data.featureimg.childImageSharp.fluid} />
      </a>
    </div>
  )
}

export default SomeImage

"@

$page = @"
import * as React from "react"
import { Link, graphql } from "gatsby"

import Bio from "../../components/bio"
import Layout from "../../components/layout"
import Seo from "../../components/seo"
import SomeImage from "../../components/images/image-__ID__"

const BlogIndex = ({ data, location }) => {
  const siteTitle = data.site.siteMetadata?.title || ``Title``
  const posts = data.allMarkdownRemark.nodes

  if (posts.length === 0) {
    return (
      <Layout location={location} title={siteTitle}>
        <Bio />
        <p>
          No blog posts found. Add markdown posts to "content/blog" (or the
          directory you specified for the "gatsby-source-filesystem" plugin in
          gatsby-config.js).
        </p>
      </Layout>
    )
  }

  return (
    <Layout location={location} title={siteTitle}>
      <Bio />
      <SomeImage />
      <ol style={{ listStyle: ``none`` }}>
        {posts.map(post => {
          const title = post.frontmatter.title || post.fields.slug

          return (
            <li key={post.fields.slug}>
              <article
                className="post-list-item"
                itemScope
                itemType="http://schema.org/Article"
              >
                <header>
                  <h2>
                    <Link to={post.fields.slug} itemProp="url">
                      <span itemProp="headline">{title}</span>
                    </Link>
                  </h2>
                  <small>{post.frontmatter.date}</small>
                </header>
                <section>
                  <p
                    dangerouslySetInnerHTML={{
                      __html: post.frontmatter.description || post.excerpt,
                    }}
                    itemProp="description"
                  />
                </section>
              </article>
            </li>
          )
        })}
      </ol>
    </Layout>
  )
}

export default BlogIndex

/**
 * Head export to define metadata for the page
 *
 * See: https://www.gatsbyjs.com/docs/reference/built-in-components/gatsby-head/
 */
export const Head = () => <Seo title="All posts" />

export const pageQuery = graphql``
  {
    site {
      siteMetadata {
        title
      }
    }
    allMarkdownRemark(sort: { frontmatter: { date: DESC } }) {
      nodes {
        excerpt
        fields {
          slug
        }
        frontmatter {
          date(formatString: "MMMM DD, YYYY")
          title
          description
        }
      }
    }
  }
``

"@

for ($i = 2; $i -lt 1002; $i++) {
  $file.Replace("__ID__", $i) | Out-File -Encoding utf8 "$PSScriptRoot/../src/components/images/image-$i.js"
  $page.Replace("__ID__", $i) | Out-File -Encoding utf8 "$PSScriptRoot/../src/pages/images/image-$i.js"
}