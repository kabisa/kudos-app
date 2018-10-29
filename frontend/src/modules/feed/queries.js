import gql from "graphql-tag";

export const GET_TRANSACTIONS = gql`
  query postsConnection {
    postsConnection {
      edges {
        cursor
        node {
          id
          kudos
          message
          receivers {
            name
          }
          sender {
            name
          }
        }
      }
    }
  }
`;
